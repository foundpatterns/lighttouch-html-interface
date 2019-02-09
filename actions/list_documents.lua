event = ["list_documents_html"]
priority = 1
input_parameters = ["request"]


-- GET /[type]
local model_name = request.path_segments[1]

local documents = {}

contentdb.walk_documents(nil,
  function (file_uuid, fields, body, store)
    if fields.model ~= model_name then return end

    -- Filter the documents using the query params
    for k, v in pairs(request.query) do
      if fields[k] ~= v then
        -- Don't add this document to the list
        return
      end
    end

    table.insert(documents, {
      name = fields.name or fields.title,
      uuid = file_uuid,
      store = store
    })
  end
)

-- TODO: Use the rest of the query or update the way it works
-- Each query parameter specifies what a document field must have

if #documents == 0 then documents = nil end

return {
  headers = {
    ["content-type"] = "text/html",
  },
  body = render("chunks/list_documents.html", {
    SITENAME = settings.sitename,
    TITLE = model_name:capitalize(),
    model = model_name,
    documents = documents
  })
}
