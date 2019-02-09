event = ["lighttouch_loaded"]
priority = 50
input_parameters = []

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

local user = settings.user
local pwd = settings.password

if not user or not pwd then
  log.warn("No user or password specified in settings.")

  user = generate()
  pwd = generate()

  log.info("Default credentials:")
  log.info("\tuser: " .. user)
  log.info("\tpassword: " .. pwd)
end

_G.auth_tokens = {
  realm = settings.sitename or ("Lighttouch App " .. generate()),
  user = user,
  pwd = pwd,
  cred = to_base64(user .. ":" .. pwd)
}
