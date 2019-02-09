event = ["request_document_edit_form"]
priority = 1
input_parameters = ["request"]

if request.forbidden then return end

local model_name, id = request.path_segments[1], request.path_segments[2]
local model = models[model_name]
local fields, body, store = contentdb.read_document(id)

return {
  headers = {
    ["content-type"] = "text/html"
  },
  body = render(settings.theme .. "/chunks/model_form.html", {
    SITENAME = settings.sitename,
    TITLE = "Edit " .. model_name:capitalize() .. " " .. id,
    model_name = model_name,
    model = model,

    id = id,
    fields = fields,
    body = body,
    store = store,
  })
}
