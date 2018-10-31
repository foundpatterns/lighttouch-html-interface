event: ["list_documents_html"]
priority: 1
input_parameters: ["request"]


-- GET /[type]
local model_name = request.path_segments[1]

local uuids = {}

content.walk_documents(nil, function (file_uuid, header, body)
  if header.type == model_name then
    table.insert(uuids, file_uuid)
  end
end)

if #uuids == 0 then uuids = nil end

return {
  headers = {
    ["content-type"] = "text/html",
  },
  body = render("list_documents.html", {model=model_name, documents=uuids})
}
