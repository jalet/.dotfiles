local tabnine_status_ok, tabnine = pcall(require, "tabnine:config")
if not tabnine_status_ok then
  return
end

tabnine:config({
  max_lines                = 1000;
  max_num_results          = 20;
  sort                     = true;
  run_on_every_keystroke   = true;
  snippet_placeholder      = "..";
  show_prediction_strength = false;
})
