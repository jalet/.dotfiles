#!/usr/bin/fish

function z_rds_proxy --description 'Setup SSM Session port forwarding via EC2 Host'
    set __REGIONS eu-west-1\neu-central-1\nus-west-1\nus-east-1
    set __PROFILES izettle-test\nProd\nizettle-planets

    set -l FZF_DEFAULT_OPTS ""
    set -l options h/help r/region= p/profile= i/identifier=
    argparse -n z_rds_proxy $options -- $argv
    or return

    if set -q _flag_h
        __fish_print_help z_rds_connect
        return 0
    end

    if not set -q _flag_r
        set _flag_r (echo $__REGIONS | fzf --header "AWS Region" --reverse --border -d 10)
    end

    if not set -q _flag_p
        set _flag_p (echo $__PROFILES | fzf --header "AWS Profile" --reverse --border -d 10)
    end

    set -x AWS_REGION $_flag_r
    set -x AWS_PROFILE $_flag_p"-LegacyAccountsDatabaseAccess"

    echo "Checking AWS SSO Session for profile $AWS_PROFILE"
    aws sts get-caller-identity --query "Arn" --output text

    if test $status = 0
        echo "Skipping login because SSO token still valid"
    else
        echo "Logging in with SSO using profile \"$AWS_PROFILE\"..."
        aws sso login
        or return 1
    end

    if not set -q _flag_i
        set _flag_i (aws rds describe-db-instances \
            --query 'DBInstances[].{name:DBInstanceIdentifier}' \
            --output text | fzf)
    end

    set -l TARGET (aws ec2 describe-instances \
        --output text \
        --filters '[{"Name": "tag:Name", "Values": ["*-bastion"]}, {"Name": "instance-state-name", "Values": ["running"]}]' \
        --query 'Reservations[0].Instances[0].InstanceId')

    set -l ENDPOINT (aws rds describe-db-instances \
        --db-instance-identifier $_flag_i \
        --query 'DBInstances[0].Endpoint.Address')

    echo $ENDPOINT
    # Create the session
    echo "Starting SSM session, on $_flag_i"
    echo "When launched, open new tab on terminal to run \"z_rds_connect -d <dbname> -i $_flag_i -r $AWS_REGION -p $AWS_PROFILE\"..."

    aws ssm start-session \
        --target $TARGET \
        --document-name AWS-StartPortForwardingSessionToRemoteHost \
        --parameters '{"host":['"$ENDPOINT"'], "portNumber":["5432"], "localPortNumber":["15610"]}'
end

