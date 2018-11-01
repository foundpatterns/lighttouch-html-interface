event: ["http_auth"]
priority: 50

-- https://tools.ietf.org/html/rfc7617

log.trace(inspect(math))

local function generate (length)
  length = length or 4
  local letters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
  local str = ""
  for i = 1, length do
    str = str .. letters[math.random(1, #letters)]
  end
  return str
end

if not _G.auth_tokens then
  local user = generate()
  local pwd = generate()

  _G.auth_tokens = {
    realm = generate(10),
    user = user,
    pwd = pwd,
    cred = to_base64(user .. ":" .. pwd)
  }

  log.info("Session authentication tokens generated")
  log.info("\tuser: " .. user)
  log.info("\tpassword: " .. pwd)
end

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
    ["WWW-Authenticate"] = 'Basic realm="lighttouch ' .. auth_tokens.realm .. '"'
  },
  body = ""
}
