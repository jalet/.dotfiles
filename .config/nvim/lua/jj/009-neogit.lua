local neogit_status_ok, neogit = pcall(require, "neogit")
if not neogit_status_ok then
	return
end

neogit.setup({
	disable_insert_on_commit = true,
	disable_commit_confirmation = true,
	integrations = {
		diffview = true,
	},
})
