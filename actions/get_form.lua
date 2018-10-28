event: ["get_document_form"]
priority: 1


local model_name = request.path_segments[1]
local model, err = content.get_model_definition(model_name)
if not model then
  return { headers = {}, status = "400", body = err }
end

local html = ""
for name, def in pairs(model.fields) do
  html = html .. '<div><label for="' .. name .. '">' .. name .. '</label><input name="' .. name .. '" id="' .. name .. '"></div>'
end

html = '<html><header><title>New ' .. model_name .. '</title></header><body><form method="POST" action="/">' .. html .. "</form></body></html>"

return {
  headers = {
    ["content-type"] = "text/html"
  },
  body = html
}
