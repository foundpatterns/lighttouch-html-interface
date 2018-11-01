event: ["lighttouch_loaded"]
priority: 50

-- https://tools.ietf.org/html/rfc7617

local function generate (length)
  length = length or 4
  local letters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
  local str = ""
  for i = 1, length do
    str = str .. letters[math.random(1, #letters)]
  end
  return str
end

local user = generate()
local pwd = generate()

_G.auth_tokens = {
  realm = generate(10),
  user = user,
  pwd = pwd,
  cred = to_base64(user .. ":" .. pwd)
}

log.info("Session authentication:")
log.info("\tuser: " .. user)
log.info("\tpassword: " .. pwd)
