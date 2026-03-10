# Betterness MCP Starter Kit for Claude

Connect Claude to live Betterness health data via MCP in 5 minutes. Direct access to 26 tools across user profiles, devices, labs, biomarkers, and payments.

## Who This Is For

- **Solo builders & consultants**: Validating Betterness health data access in demos or prototypes
- **Teams kicking off integration**: First-run validation before scaling to production
- **Claude users**: Engineers and builders using Claude Desktop, Claude Code, or Cursor for health data workflows

## What Problem It Solves

Betterness health data lives behind authenticated REST APIs. This kit bridges Claude to your Betterness account via MCP (Model Context Protocol), so Claude can:
- Fetch user profiles and connected devices
- Query lab results, biomarker trends, and health metrics
- Manage lab orders and payments
- Build intelligent health agents without custom backend code

No backend integration needed. Pure Claude + MCP.

## Fastest Start (5 Minutes)

### 1. Sign Up for Betterness
Go to [betterness.ai](https://betterness.ai) and create an account or sign in if you already have one.

### 2. Generate an MCP API Key
1. Navigate to `betterness.ai/mcp/keys` (or the MCP dashboard in your account)
2. Click **Generate New Key**
3. Copy the Bearer token (format: `sk_live_...`)
4. Save it securely (you'll paste it in the next step)

### 3. Configure Claude Desktop or Claude Code
Choose your environment below and paste the configuration.

---

## Exact Configuration

### Claude Desktop (macOS / Windows / Linux)

Open `~/Library/Application Support/Claude/claude_desktop_config.json` (macOS) or `%APPDATA%\Claude\claude_desktop_config.json` (Windows).

Paste this under `mcpServers`:

```json
{
  "mcpServers": {
    "betterness": {
      "url": "https://api.betterness.ai/mcp",
      "type": "stdio",
      "transport": "http",
      "auth": {
        "type": "bearer",
        "token": "YOUR_API_KEY_HERE"
      }
    }
  }
}
```

Replace `YOUR_API_KEY_HERE` with your Bearer token from Step 2.

Restart Claude Desktop. You should see a Betterness icon in the sidebar.

### Claude Code / Cursor

Use the Claude Code CLI to register the MCP server:

```bash
claude mcp add betterness \
  --url https://api.betterness.ai/mcp \
  --type http \
  --auth bearer \
  --token sk_live_YOUR_KEY_HERE
```

Or edit `~/.claude/mcp-servers.json` directly and add:

```json
{
  "servers": {
    "betterness": {
      "url": "https://api.betterness.ai/mcp",
      "type": "http",
      "auth": {
        "type": "bearer",
        "token": "sk_live_YOUR_KEY_HERE"
      }
    }
  }
}
```

---

## Agent Handoff Prompt

Use this system prompt to give Claude context about its Betterness capabilities:

```
You are a health intelligence assistant with direct access to Betterness health data via MCP.

You have 26 live tools across these domains:
- User & Profile: getUser, updateUserProfile, getUserConnectedDevices
- Health Data: getUserLabData, getUserHealthMetrics, getBiomarkerTrends
- Biomarkers & Labs: searchBiomarkers, getBiomarkerDetails, listLabTests, getLabOrderStatus
- Lab Ordering: createLabOrder, estimateLabCost, updateLabOrder
- Device Management: listConnectedDevices, getDeviceData, linkDevice
- Payments: getPaymentMethods, recordPayment, getInvoices

When a user asks about their health:
1. Query relevant data using the MCP tools (e.g., getUserLabData, getBiomarkerTrends)
2. Synthesize results into clear insights
3. If data is missing, tell the user what's needed (new lab order, device sync, etc.)

Always respect user privacy. Never share data outside the conversation.
```

---

## First-Use Prompt

Test the connection by asking Claude this:

```
What devices do I have connected to Betterness, and what was my most recent lab result?
```

Claude should:
1. Call `listConnectedDevices` (or `getUserConnectedDevices`)
2. Call `getUserLabData`
3. Return your device names and latest lab result

If you see data back, you're connected.

---

## Smoke Tests

Verify all three core capabilities before production:

### Test 1: List Connected Devices
```
Ask Claude: "What devices am I tracking?"
```
Claude calls `listConnectedDevices`. You should see device names, types, and last sync timestamps.

**Success**: Device list appears (e.g., "Apple Watch, Oura Ring, Withings Scale").

### Test 2: Get Lab Data
```
Ask Claude: "What were my last 3 lab results?"
```
Claude calls `getUserLabData`. You should see lab test names, dates, and values.

**Success**: Lab result names, dates, and biomarker values appear.

### Test 3: Search Biomarkers
```
Ask Claude: "Show me biomarkers related to glucose and insulin."
```
Claude calls `searchBiomarkers`. You should see matching biomarker names and units.

**Success**: Biomarker list appears (e.g., "Glucose, Insulin, HbA1c, Fasting Glucose").

---

## Troubleshooting

### "MCP connection refused" or "401 Unauthorized"
**Cause**: API key is missing, expired, or wrong format.

**Fix**:
1. Go to `betterness.ai/mcp/keys` and verify your key exists
2. Check the token format: should start with `sk_live_`
3. Copy the full token (no extra spaces)
4. Restart Claude Desktop completely (quit and reopen)

### "Tool returned no data"
**Cause**: Your Betterness account has no devices, labs, or biomarkers yet.

**Fix**:
1. Log into [betterness.ai](https://betterness.ai)
2. Link a device (Apple Watch, Oura, Withings, etc.) or upload a lab result
3. Wait 1–2 minutes for data to sync
4. Try the smoke test again in Claude

### "Rate limit exceeded"
**Cause**: You've hit the API rate limit (100 requests/minute).

**Fix**:
1. Wait 60 seconds
2. Retry the request
3. For production, contact support@betterness.ai for higher limits

### Claude says "Tool not found" or "betterness MCP not available"
**Cause**: MCP server didn't start or config is malformed JSON.

**Fix**:
1. Check your config file for syntax errors (use a JSON validator)
2. Ensure the `url` is exactly `https://api.betterness.ai/mcp` (no trailing slash)
3. Verify Bearer token is in the right field
4. Restart Claude Desktop

---

## Upgrade Path

### Next Steps
- **Mission Control**: Access `betterness.ai/dashboard` for user management, team collaboration, and advanced reporting
- **Prompt Packs**: Visit `betterness.ai/prompts` for specialized Claude prompts for nutrition, fitness, sleep, and biomarker analysis
- **Use-Case Playbooks**: Download templates for building health dashboards, lab order workflows, and biomarker alert systems

### Scaling to Production
- Generate a new API key per environment (dev, staging, prod)
- Store tokens in environment variables or secure vaults, never in code
- Monitor rate limits; contact support for higher quotas
- Implement error handling and retry logic for production agents

---

## Support Path

### Get Help
- **GitHub Issues**: Report bugs or request features at [github.com/betterness/mcp](https://github.com/betterness/mcp)
- **Build With Us**: Join the Betterness builder community at [betterness.ai/builders](https://betterness.ai/builders)
- **Email**: Direct questions to support@betterness.ai

### Community & Docs
- **MCP Spec**: Learn more about Model Context Protocol at [modelcontextprotocol.io](https://modelcontextprotocol.io)
- **Betterness Docs**: Full API reference and architecture guides at [docs.betterness.ai](https://docs.betterness.ai)

---

## Current Limitations

1. **Read-only on device linking**: You can query connected devices but cannot programmatically link new devices via MCP. Device linking must happen at [betterness.ai](https://betterness.ai).

2. **Lab ordering is US-only**: `createLabOrder` and related tools currently support US-based addresses and insurance. International support coming Q3 2026.

3. **No real-time sync**: Device data syncs every 15 minutes. The MCP returns the latest available data; real-time streaming is on the roadmap.

4. **Biomarker reference ranges are population-based**: Individual reference ranges (e.g., lab-specific or age/sex-adjusted) are available via the REST API but not yet exposed in the MCP tool set. Use `getBiomarkerDetails` to get population averages.

5. **No historical data export**: You can query recent lab data and trends via MCP, but bulk historical exports (CSV, JSON) must be done via the Betterness dashboard.

6. **Rate limits**: 100 requests/minute per API key. No concurrent request limit, but very large batch operations may need to be split across multiple API keys or time windows.

7. **Auth0 session required**: Claude must be signed in to your Betterness account via Auth0 to generate and manage API keys. Service account tokens are on the roadmap.

---

**Last Updated**: March 2026
**Status**: Stable (Beta)
**Next Review**: June 2026
