#!/usr/bin/fish

function z_rds_connect --description 'Connect to AWS RDS with SSM Session'
    set __REGIONS eu-west-1\neu-central-1\nus-west-1\nus-east-1
    set __PROFILES izettle-test\nProd\nizettle-planets

    set -l options h/help r/region= p/profile= i/identifier= u/username= d/dbname=+
    argparse -n z_rds_connect $options -- $argv
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

    if not set -q _flag_u
        set _flag_u (whoami)-a@paypal.com
    end

    set -x AWS_REGION $_flag_r
    set -x AWS_PROFILE $_flag_p"-LegacyAccountsDatabaseAccess"

    if not set -q _flag_i
        set _flag_i (aws rds describe-db-instances \
            --query 'DBInstances[].{name:DBInstanceIdentifier}' \
            --output text | fzf)
    end

    set -l ENDPOINT (aws rds describe-db-instances \
        --db-instance-identifier $_flag_i \
        --query 'DBInstances[0].Endpoint.Address' \
        --output text)

    set -l PGPASSWORD (aws rds generate-db-auth-token --hostname $ENDPOINT --port 5432 --username $_flag_u)

    # Connect
    psql "host=127.0.0.1 port=15610 user=$_flag_u password=$PGPASSWORD dbname=$_flag_d"
end

