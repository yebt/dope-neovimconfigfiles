function skeleton()
  --local ft =  vim.bo.filetype
  --local ft =  vim.api.nvim_buf_get_option(0,"filetype")

  local ext = vim.fn.expand('%:e')
  local buf_name = vim.fn.expand('%:t')

  local file_ext_exceptions = {}
  local file_name_exceptions = {
    -- ["web.php"] =  "skeleton.web.php"
  }

  local skeleton_name = 'skeleton.' .. ext
  if file_name_exceptions[buf_name] then
    skeleton_name = file_name_exceptions[buf_name]
  elseif file_ext_exceptions[buf_name] then
    skeleton_name = file_ext_exceptions[buf_name]
  end

  -- Verifica si el archivo de esqueleto existe
  local template_path = vim.fn.expand('~/.config/nvim/templates/' .. skeleton_name)
  if vim.fn.filereadable(template_path) == 1 then
    -- Ejecuta la acción para leer el esqueleto y pegarlo al principio del buffer
    vim.cmd(':silent 0r ' .. template_path)
    vim.notify('Template loaded for new file from ->  ' .. skeleton_name)
  end
end

vim.api.nvim_create_user_command('LoadSkeleton', skeleton, {})
