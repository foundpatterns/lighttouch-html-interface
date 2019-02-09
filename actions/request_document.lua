event = ["request_document_html"]
priority = 1
input_parameters = ["request"]


-- GET /[type]/[uuid]
local model_name, id = request.path_segments[1], request.path_segments[2]

local fields, body, store = contentdb.read_document(id)
if not fields then
  return {
    headers = { ["content-type"] = "application/json" },
    body = json.from_table({msg="Document not found"})
  }
end

if fields.model ~= model_name then
  return {
    headers = { ["content-type"] = "application/json" },
    body = json.from_table({msg="Document is not of model " .. model_name})
  }
end

local subdocuments = {}

contentdb.walk_documents(nil, function (doc_id, fields, body, store)
  if fields[model_name] == id then

    local docs = subdocuments[fields.model]
    if not docs then
      docs = {}
      subdocuments[fields.model] = docs
    end

    table.insert(docs, {
      name = fields.name or fields.title,
      uuid = doc_id,
      store = store
    })
  end
end)

if count_pairs(subdocuments) == 0 then subdocuments = nil end

return {
  headers = { ["content-type"] = "text/html" },
  body = render("chunks/show_document.html", {
    SITENAME = settings.sitename,
    TITLE = model_name:capitalize() .. " " .. id,
    model = model_name,
    id = id,
    store = store,
    fields = fields,
    body = body,
    subdocuments = subdocuments,
  })
}
