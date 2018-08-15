# Kong Okta Auth Plugin

Kong Plugin to validate OAuth 2.0 access tokens against an OKTA Authorization Server. The validation is made using [OKTA's introspection endpoint](https://developer.okta.com/docs/api/resources/oauth2.html#introspection-request).

When enabled, this plugin will validate the token.

## Enabling Plugin

You can enable Okta-Auth plugin for an api with the following request:

```bash
curl -X POST http://localhost:8001/apis/example-api/plugins \
  --data "name=okta-auth" \
  --data "config.authorization_server=https://okta.com/oauth2/auth-server-id" \
  --data "config.client_id=cid" \
  --data "config.client_secret=secret" \
  --data "config.api_version=v1" \
  --data "config.check_auth_server=true"
```

Parameters description:

form parameter|required|description
---|---|---
`name` | *required* | Plugin name: `okta-auth`
`authorization_server` | *required* | Okta authorization server URL
`client_id` | *required*| Okta's public identifier for the client
`client_secret` | *required* | Okta's client secret
`api_version` | *optional* | Okta's authorization server API version (default: `v1`)
`check_auth_server` | *optional* | If *true* check authorization server availability (default: `true`)


