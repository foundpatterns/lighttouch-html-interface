event: ["request_document_html"]
priority: 1
input_parameters: ["request"]


-- GET /[type]/[uuid]
local model_name, id = request.path_segments[1], request.path_segments[2]

local fields, body, profile = content.read_document(id)
if not fields then
  return {
    headers = { ["content-type"] = "application/json" },
    body = json.from_table({msg="Document not found"})
  }
end

if fields.type ~= model_name then
  return {
    headers = { ["content-type"] = "application/json" },
    body = json.from_table({msg="Document is not of model " .. model_name})
  }
end


return {
  headers = { ["content-type"] = "text/html" },
  body = render("show_document.html", {
    model = model_name,
    id = id,
    profile = profile,
    fields = fields,
    body = body
  })
}