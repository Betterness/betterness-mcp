# Troubleshooting Common Issues

This guide covers the most frequently encountered issues when connecting to and using the Betterness MCP server.

## Quick Reference

| Error | Status | Most Likely Cause | Fix |
|-------|--------|-------------------|-----|
| Unauthorized | 401 | Invalid or expired API key | Regenerate key at betterness.ai/mcp/keys |
| Not Found | 404 | Wrong endpoint URL | Use `https://api.betterness.ai/mcp` exactly |
| Rate Limited | 429 | Too many requests | Back off and retry with exponential delay |
| Tool Not Found | N/A | Misspelled tool name or stale cache | Call `tools/list` to get current tool names |
| No Data Returned | N/A | No data sources connected | Link wearables/labs in Betterness dashboard |
| Connection Timeout | N/A | Network or firewall issue | Check connectivity to api.betterness.ai |
| CORS Error | N/A | Browser-based client hitting MCP directly | Use a server-side proxy |
| Session Error | N/A | Stale or invalid session | Reinitialize the MCP connection |

## Detailed Troubleshooting

### 401 Unauthorized

**Symptoms:**
- Response body contains `{"error": "Unauthorized"}` or similar
- HTTP status code 401

**Causes and fixes:**

1. **Expired API key** — Keys expire after the period shown when they were generated. Go to [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys) and generate a new one. Update your client configuration.

2. **Malformed Authorization header** — The header must be exactly `Authorization: Bearer YOUR_KEY` with a single space between `Bearer` and the key. No quotes around the key.

3. **Key revoked** — If you regenerated a key, the old one is automatically revoked. Update all clients using the old key.

4. **Wrong key scope** — Some keys may be scoped to specific tools. Verify your key has access to the tool you are calling.

**Diagnostic command:**
```bash
curl -s -o /dev/null -w "%{http_code}" \
  -H "Authorization: Bearer YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' \
  https://api.betterness.ai/mcp
```
If this returns `200`, your key is valid. If `401`, the key is the problem.

### 404 Not Found

**Symptoms:**
- HTTP status code 404
- "Route not found" or empty response

**Causes and fixes:**

1. **Wrong URL** — The correct endpoint is `https://api.betterness.ai/mcp`. Common mistakes:
   - Missing `/mcp` path
   - Using `http://` instead of `https://`
   - Adding a trailing slash (some clients are sensitive to this)
   - Using `www.` prefix

2. **Wrong HTTP method** — The MCP endpoint accepts `POST` only. `GET` requests will return 404.

3. **Incorrect JSON-RPC method name** — Valid methods include `initialize`, `tools/list`, `tools/call`, and `resources/list`. Check spelling.

### 429 Rate Limited

**Symptoms:**
- HTTP status code 429
- Response includes `Retry-After` header

**Rate limits:**

| Plan | Requests/minute | Requests/day |
|------|----------------|--------------|
| Free | 30 | 1,000 |
| Pro | 120 | 10,000 |
| Clinic | 600 | 100,000 |
| Enterprise | Custom | Custom |

**How to handle:**

1. **Respect the `Retry-After` header** — Wait the specified number of seconds before retrying.

2. **Implement exponential backoff** — If no `Retry-After` header, use exponential backoff starting at 1 second:
   ```
   Retry 1: wait 1s
   Retry 2: wait 2s
   Retry 3: wait 4s
   Retry 4: wait 8s
   (max 5 retries)
   ```

3. **Batch your requests** — Instead of calling `getSleepData` for each day individually, use date ranges to fetch multiple days in one call.

4. **Cache responses** — Health data does not change retroactively. Cache historical data locally and only fetch new data.

5. **Upgrade your plan** — If you consistently hit limits, your usage pattern may require a higher tier.

### Tool Not Found

**Symptoms:**
- MCP response includes error about unknown tool
- `{"error": {"code": -32601, "message": "Tool not found: ..."}}`

**Causes and fixes:**

1. **Misspelled tool name** — Tool names are case-sensitive. Call `tools/list` to get the exact names:
   ```json
   {"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}
   ```

2. **Tool removed or renamed** — The tool set may have been updated since your client was configured. Refresh your tool list.

3. **Stale client cache** — Some MCP clients cache the tool list. Restart the client or force a refresh.

4. **Insufficient permissions** — Some tools require specific plan tiers or data source connections. Check that your account has access to the tool.

### No Data Returned

**Symptoms:**
- Tool call succeeds (no error) but returns empty results
- `{"result": {"content": []}}`

**Causes and fixes:**

1. **No data sources connected** — You must link at least one health data source in the Betterness dashboard. Supported sources include:
   - Wearables (Oura, Whoop, Apple Health, Garmin, Fitbit)
   - Lab providers (Quest, Labcorp, custom uploads)
   - Manual entries

2. **Date range has no data** — You may be querying a period before you connected your devices. Try a more recent date range.

3. **Wrong data type for device** — Not all devices provide all data types. For example, a basic fitness tracker may not have SpO2 data. Check `listConnectedDevices` to see which data types each device supports.

4. **Data sync delay** — New device connections may take up to 24 hours for historical data to backfill. Recent data typically syncs within 1-2 hours.

5. **Account has no lab data** — Lab-related tools (`getUserLabRecords`, `searchBiomarkers`) require lab results to be uploaded or synced. Use `listAvailableLabTests` to see what can be ordered.

### Connection Timeout

**Symptoms:**
- Request hangs and eventually fails
- Client reports "connection timed out" or "ETIMEDOUT"

**Causes and fixes:**

1. **Network connectivity** — Verify you can reach the endpoint:
   ```bash
   curl -v https://api.betterness.ai/mcp
   ```

2. **Firewall or proxy blocking** — Corporate firewalls may block outbound HTTPS to unknown domains. Whitelist `api.betterness.ai` on port 443.

3. **VPN interference** — Some VPNs route traffic through regions with high latency to Betterness servers. Try disconnecting the VPN to test.

4. **DNS resolution failure** — Try resolving the hostname directly:
   ```bash
   nslookup api.betterness.ai
   ```

5. **Client timeout too short** — Some MCP clients default to short timeouts (5-10 seconds). Complex tool calls may take 10-15 seconds. Increase the timeout in your client configuration to at least 30 seconds.

6. **Betterness service outage** — Check [status.betterness.ai](https://status.betterness.ai) for current service status.

### CORS Issues

**Symptoms:**
- Browser console shows "Access-Control-Allow-Origin" errors
- Requests fail from browser-based applications

**Cause:**

The Betterness MCP endpoint is designed for server-to-server communication, not direct browser access. Browsers enforce CORS policies that prevent JavaScript from calling the MCP endpoint directly.

**Fix:**

Do not call the Betterness MCP endpoint directly from browser JavaScript. Instead:

1. **Use a server-side proxy** — Create a backend API route that forwards requests to the MCP endpoint. See [ChatGPT Actions guide](../clients/chatgpt-actions.md) for an Express.js proxy example.

2. **Use an MCP client application** — Claude Desktop, Clawbot, and other desktop/CLI MCP clients do not have CORS restrictions.

3. **Use a Next.js API route** — If your app is built with Next.js, create an API route that calls the MCP endpoint server-side:
   ```typescript
   // app/api/health/sleep/route.ts
   export async function GET(request: Request) {
     const result = await fetch("https://api.betterness.ai/mcp", {
       method: "POST",
       headers: {
         Authorization: `Bearer ${process.env.BETTERNESS_API_KEY}`,
         "Content-Type": "application/json",
       },
       body: JSON.stringify({
         jsonrpc: "2.0",
         id: 1,
         method: "tools/call",
         params: { name: "getSleepData", arguments: {} },
       }),
     });
     return Response.json(await result.json());
   }
   ```

### Session Management Issues

**Symptoms:**
- "Session expired" or "Invalid session" errors
- Tool calls fail after a period of inactivity
- `{"error": {"code": -32600, "message": "Session not found"}}`

**Causes and fixes:**

1. **Session timeout** — MCP sessions expire after 30 minutes of inactivity. Your client should handle session expiration by reinitializing:
   ```json
   {"jsonrpc":"2.0","id":1,"method":"initialize","params":{
     "clientInfo": {"name": "my-client", "version": "1.0.0"},
     "protocolVersion": "2025-03-26"
   }}
   ```

2. **Server restart** — If the Betterness MCP server is restarted (during deployments), existing sessions are invalidated. Implement reconnection logic in your client.

3. **Multiple sessions** — Each API key supports a limited number of concurrent sessions. Close unused sessions or use a single persistent connection.

## Getting Help

If none of the above resolves your issue:

1. **Check the status page**: [status.betterness.ai](https://status.betterness.ai)
2. **Search existing issues**: [github.com/betterness/mcp/issues](https://github.com/betterness/mcp/issues)
3. **Open a new issue**: Include your error message, client type, and the steps to reproduce
4. **Community Discord**: [discord.gg/betterness](https://discord.gg/betterness) in the #mcp-support channel
