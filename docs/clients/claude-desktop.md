# Connecting Betterness MCP to Claude Desktop

Connect your Betterness health data to Claude Desktop and Claude Code for conversational health intelligence.

## Prerequisites

1. **Betterness account** at [betterness.ai](https://betterness.ai)
2. **MCP API key** generated at [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys)
3. **Claude Desktop** installed ([download](https://claude.ai/download)) or **Claude Code CLI**

## Claude Desktop Setup

### Step 1: Locate your config file

| Platform | Path |
|----------|------|
| macOS | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Windows | `%APPDATA%\Claude\claude_desktop_config.json` |
| Linux | `~/.config/Claude/claude_desktop_config.json` |

If the file does not exist, create it.

### Step 2: Edit the config

Open the config file in any text editor and add the Betterness MCP server to the `mcpServers` block:

```json
{
  "mcpServers": {
    "betterness": {
      "url": "https://api.betterness.ai/mcp",
      "transport": "streamable-http",
      "auth": {
        "type": "bearer",
        "token": "YOUR_BETTERNESS_API_KEY"
      }
    }
  }
}
```

Replace `YOUR_BETTERNESS_API_KEY` with the key you generated at betterness.ai/mcp/keys.

If you already have other MCP servers configured, add the `"betterness"` entry alongside them inside the existing `mcpServers` object.

### Step 3: Restart Claude Desktop

Quit Claude Desktop completely and relaunch it. The Betterness tools will appear in the tool picker (hammer icon) at the bottom of the chat window.

## Claude Code CLI Setup

If you use Claude Code from the terminal, add the server with a single command:

```bash
claude mcp add betterness \
  --url https://api.betterness.ai/mcp \
  --type http \
  --auth bearer \
  --token YOUR_BETTERNESS_API_KEY
```

Verify the connection:

```bash
claude mcp list
```

You should see `betterness` listed with a `connected` status.

## Smoke Tests

After setup, try these prompts in Claude Desktop to confirm everything works:

### 1. List connected devices

```
What health devices do I have connected to Betterness?
```

Claude will call `listConnectedDevices` and return your linked wearables and data sources.

### 2. Retrieve lab data

```
Show me my most recent lab results.
```

Claude will call `getUserLabData` and display your biomarker panels.

### 3. Search biomarkers

```
What do my Vitamin D levels look like over time?
```

Claude will call `searchBiomarkers` with the relevant query and chart your trend.

## Example Prompts

Once connected, try these to explore your health data:

| Prompt | Tools Used |
|--------|------------|
| "How did I sleep last night?" | `getSleepData`, `getSleepStages` |
| "Am I ready for a hard workout today?" | `getSleepData`, `getVitals`, `getActivityData` |
| "What's my biological age trend?" | `getBiologicalAge` |
| "Which labs should I order next?" | `getUserLabData`, `listAvailableLabTests` |
| "Compare my HRV this week vs last week" | `getVitals` |
| "Give me a full health briefing" | Multiple tools composed together |
| "What biomarkers are outside normal range?" | `getUserLabData`, `searchBiomarkers` |
| "Help me design a sleep optimization protocol" | `getSleepData`, `getSleepStages`, `getVitals` |

## Troubleshooting

### 401 Unauthorized

- **Cause**: Invalid or expired API key.
- **Fix**: Generate a new key at [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys) and update your config file. Restart Claude Desktop.

### Tools not appearing

- **Cause**: Config file syntax error or Claude Desktop not restarted.
- **Fix**: Validate your JSON (use a linter or `python -m json.tool claude_desktop_config.json`). Quit and relaunch Claude Desktop — do not just close the window.

### "No data returned"

- **Cause**: No health data synced to your Betterness account yet.
- **Fix**: Connect at least one data source (wearable, lab provider) in the Betterness dashboard. Some tools require specific data types — `getSleepData` needs a sleep-tracking device linked.

### Connection timeout

- **Cause**: Network issues or firewall blocking the MCP endpoint.
- **Fix**: Confirm you can reach `https://api.betterness.ai/mcp` from your browser. Check that your firewall or VPN allows outbound HTTPS on port 443.

### Claude says it cannot use health tools

- **Cause**: The MCP server is not connected or tools were not loaded.
- **Fix**: Check the tool picker icon in Claude Desktop. If Betterness tools are not listed, revisit the config steps above. In Claude Code, run `claude mcp list` to verify.

## Security Notes

- Your API key is stored locally in the config file. Do not commit it to version control.
- All communication between Claude Desktop and the Betterness MCP server uses HTTPS with TLS 1.3.
- Betterness never stores your Claude conversations. The MCP server processes tool calls statelessly.
- You can revoke your API key at any time from [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys).
