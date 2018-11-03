event: ["get_document_form"]
priority: 1
input_parameters: ["request"]

if request.forbidden then return end

local model_name = request.path_segments[1]
local model, err = content.get_model_definition(model_name)
if not model then
  return { headers = {}, status = "400", body = err }
end

return {
  headers = {
    ["content-type"] = "text/html"
  },
  body = render("model_form.html", {
    model_name = model_name,
    model = model
  })
}
