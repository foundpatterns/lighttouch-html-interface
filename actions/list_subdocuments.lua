event = ["list_subdocuments_html"]
priority = 1
input_parameters = ["request"]


-- GET /[type]
local base_model = request.path_segments[1]
local document_uuid = request.path_segments[2]
local model_name = request.path_segments[3]

local documents = {}

contentdb.walk_documents(nil, function (doc_id, fields, body, store)
  if fields.model ~= model_name then return end
  if fields[base_model] == document_uuid then
    table.insert(documents, {
      name = fields.name or fields.title,
      uuid = doc_id,
      store = store
    })
  end
end)


if #documents == 0 then documents = nil end

return {
  headers = {
    ["content-type"] = "text/html",
  },
  body = render("chunks/list_documents.html", {
    title = model_name:capitalize() .. " for " .. document_uuid,
    model = model_name,
    documents = documents
  })
}
