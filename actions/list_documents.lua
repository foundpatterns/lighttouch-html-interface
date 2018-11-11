event: ["list_documents_html"]
priority: 1
input_parameters: ["request"]


-- GET /[type]
local model_name = request.path_segments[1]

local uuids = {}

content.walk_documents(nil, function (file_uuid, header, body, profile)

  if header.model == model_name
  or header.type == model_name -- Compatibility
  then

    -- Further filter documents using the query params
    for k, v in pairs(request.query) do
      if header[k] ~= v then
        -- Don't add this document to the list
        return
      end
    end

    table.insert(uuids, {file=file_uuid, profile=profile})
  end
end)

if #uuids == 0 then uuids = nil end

return {
  headers = {
    ["content-type"] = "text/html",
  },
  body = render("list_documents.html", {model=model_name, documents=uuids})
}
