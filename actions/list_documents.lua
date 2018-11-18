event: ["list_documents_html"]
priority: 1
input_parameters: ["request"]


-- GET /[type]
local model_name = request.path_segments[1]

local uuids = {}

-- Tantivy
log.trace("Start tantivy search")
local uuid_field = content.schema:get_field("uuid")
local model_field = content.schema:get_field("model")

local parser = tan.query_parser_for_index(content.index, {uuid_field, model_field})
local coll = tan.top_collector_with_limit(10)
local result = content.index:search(parser, model_name, coll)
for i = 1, #result do
  local doc = result[i]
  table.insert(uuids, {
    file = doc:get_first(uuid_field),
    profile = "unknown_profile"
  })
end
log.trace("End tantivy search")

--[[
content.walk_documents(nil, function (file_uuid, header, body, profile)

  if header.model == model_name then

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
]]

if #uuids == 0 then uuids = nil end

return {
  headers = {
    ["content-type"] = "text/html",
  },
  body = render("list_documents.html", {model=model_name, documents=uuids})
}
