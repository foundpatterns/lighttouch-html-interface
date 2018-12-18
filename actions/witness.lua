event = ["witness_html"]
priority = 50
input_parameters = ["request"]

-- https://tools.ietf.org/html/rfc7617

local document_id = request.query.witness
local witness_id, err = keys.witness_document(document_id)
if witness_id then
  return {
    status = 303,
    headers = {
      location = "/witness/" .. witness_id
    },
    body = ""
  }
else
  return {
    status = 404,
    headers = {
      ["content-type"] = "text/html"
    },
    body = "<html><body>" .. err .. "</body></html>"
  }
end
