local okta_api = require "kong.plugins.okta-auth.okta_api"
local json = require "cjson"

local _M = {}

local function extract_token(request)
  local authorization = request.get_headers()["authorization"]
  if not authorization then return nil end

  return string.match(authorization,
    '^[Bb]earer ([A-Za-z0-9-_]+%.[A-Za-z0-9-_]+%.[A-Za-z0-9-_]+)$'
  )
end

local function is_token_valid(token_data)
  return token_data['active']
end

local function extract_data(token_data, conf)
  local extracted_data = {}
  for claim_key,claim_value in pairs(token_data) do
    for _,claim_pattern in pairs(conf.claims_to_include) do
      if string.match(claim_key, "^"..claim_pattern.."$") then
        extracted_data[claim_key] = token_data[claim_key]
      end
    end
  end

  return extracted_data
end

function _M.execute(request, conf)
  local token = extract_token(request)
  if not token then return nil end

  response = okta_api.introspect(
    conf.authorization_server,
    conf.api_version,
    conf.client_id,
    conf.client_secret,
    token
  )

  if not response then return false end

  local token_data = json.decode(response)
  return is_token_valid(token_data), extract_data(token_data, conf)
end

return _M
