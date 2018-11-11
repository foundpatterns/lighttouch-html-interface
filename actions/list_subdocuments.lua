event: ["list_subdocuments_html"]
priority: 1
input_parameters: ["request"]


-- GET /[type]
local base_model = request.path_segments[1]
local document_uuid = request.path_segments[2]
local model_name = request.path_segments[3]

local uuids = {}

content.walk_documents(nil, function (file_uuid, header, body, profile)

  if header.model == model_name
  and header[base_model] == document_uuid
  then
    table.insert(uuids, file_uuid)
  end
end)

if #uuids == 0 then uuids = nil end

return {
  headers = {
    ["content-type"] = "text/html",
  },
  body = render("list_subdocuments.html", {base_uuid=document_uuid, model=model_name, documents=uuids})
}
