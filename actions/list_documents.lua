event: ["list_documents_html"]
priority: 1
input_parameters: ["request"]


-- GET /[type]
local model_name = request.path_segments[1]

local documents = {}

-- "model:" says to look specifically in the model field
-- + means it's required
-- model_name is a single word so there's no need to treat it specially
local result = content.query("+model:" .. model_name)

for i = 1, #result do
  local doc = result[i]
  table.insert(documents, {
    file = doc:get_first(content.fields.uuid),
    profile = doc:get_first(content.fields.store)
  })
end

-- TODO: Use the rest of the query or update the way it works
-- Each query parameter specifies what a document field must have

if #documents == 0 then documents = nil end

return {
  headers = {
    ["content-type"] = "text/html",
  },
  body = render("list_documents.html", {model=model_name, documents=documents})
}
