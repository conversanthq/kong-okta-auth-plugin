_G.ngx = require "spec.okta-auth.ngx"

local access = require "kong.plugins.okta-auth.access"
local handler = require "kong.plugins.okta-auth.handler"
local responses = require "kong.tools.responses"
local request = ngx.req

describe("Handler", function()
  it("Check if response is unauthorized if token is invalid", function()
    stub(access, "execute").returns(false)
    stub(responses, "send_HTTP_UNAUTHORIZED")

    handler.access({})

    assert.stub(responses.send_HTTP_UNAUTHORIZED).was_called()

    access.execute:revert()
    responses.send_HTTP_UNAUTHORIZED:revert()
  end)
end)
