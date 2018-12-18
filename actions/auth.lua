event = ["http_auth"]
priority = 50
input_parameters = ["request"]

-- https://tools.ietf.org/html/rfc7617

if request.headers["authorization"] then
  local parts = request.headers["authorization"]:split(" ")
  if parts[1] == "Basic" and parts[2] == auth_tokens.cred then
    -- Stop here to not fail the request
    return
  end
end

request.forbidden = true
return {
  status = 401,
  headers = {
    ["WWW-Authenticate"] = 'Basic realm="' .. auth_tokens.realm .. '"'
  },
  body = ""
}
