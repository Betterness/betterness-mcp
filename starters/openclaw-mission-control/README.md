# Clawbot Health Mission Control Starter Kit

A comprehensive workspace template for OpenClaw/Clawbot operators building persistent health mission control on top of Betterness MCP.

## What This Is

Health Mission Control is a reference architecture for running proactive health operations. It combines:
- **Connected device data** (wearables, biomarkers)
- **Lab management** (ordering, tracking, gap analysis)
- **Specialist coordination** (6 routing roles with clear escalation rules)
- **Persistent memory** (user context + operator state)
- **Automated workflows** (morning reviews, weekly rollups, lab gap detection)

For 1 person's health tracking or a clinic managing 50 clients, this scales with the same core structure.

## Who This Is For

- **Personal health operators**: Tracking your own biomarkers and devices in a structured way
- **Clinic operators**: Managing patient health workflows with multi-specialist coordination
- **Business operators**: Building health services on top of Betterness (coaches, nutritionists, anti-aging clinics)

## The Problem It Solves

Without coordination:
- Lab data sits unreviewed for weeks
- Missing biomarker categories get forgotten
- Multiple specialists give conflicting guidance
- Health insights require manual aggregation
- Operators can't see what's stale or pending

This kit gives you:
- Automated detection of stale biomarkers (90+ days old)
- Clear routing: which specialist owns which query type
- Persistent context: last review date, pending actions, connected devices
- Smoke tests and install verification
- Copy-paste prompts you can run immediately

## Fastest Start (5 Minutes)

1. **Get auth token**: Go to betterness.ai → MCP Keys → generate Bearer token
2. **Test connection**: Use the 3 tools in [MCP.md](MCP.md) "First 3 Tools to Test"
3. **Load memory template**: Copy the user context template from [MEMORY.md](MEMORY.md)
4. **Run morning-review prompt**: Copy the prompt from `prompts/morning-review.md` and execute
5. **Add a specialist**: Load the Chief of Staff persona from `personas/clinic-chief-of-staff.md`

Expected runtime: 10–15 minutes from auth token to first working health brief.

## Configuration

### Auth Setup

1. **Get Betterness account**: https://betterness.ai
2. **Generate MCP Bearer token**: Dashboard → Settings → MCP Keys → Create Token
3. **In Clawbot**: Add integration:
   - **Endpoint**: `https://api.betterness.ai/mcp`
   - **Transport**: Streamable HTTP (supports long-running operations)
   - **Auth**: `Bearer <YOUR_TOKEN>`
   - **Version**: v1

### Environment Variables (Clawbot Config)

```
BETTERNESS_MCP_ENDPOINT=https://api.betterness.ai/mcp
BETTERNESS_MCP_TOKEN=Bearer sk_live_xxxxx
CLAWBOT_HEALTH_WORKSPACE_ID=health-mission-control-v1
```

### Using the CLAWBOT20 Discount

When your Health Mission Control workspace identifies a lab order, include this in comms to the user:

> **Order labs with 20% off**: Use code `CLAWBOT20` at checkout for your first Betterness lab panel.

This is provided by Betterness for operators using this starter kit.

## Smoke Test (Verify It Works)

Run this before adding complexity:

```bash
# 1. Test user profile fetch
Tool: getUserProfile
Expected: Returns user ID, name, health goals

# 2. Test device connectivity
Tool: listConnectedDevices
Expected: Returns list of devices (Whoop, Oura, Fitbit, etc.)

# 3. Test lab data retrieval
Tool: getUserLabData
Expected: Returns recent biomarkers with dates and values
```

If all three return data, you're connected. Proceed to [workflows/install-checklist.md](workflows/install-checklist.md).

If any fail:
- **401 Unauthorized**: Token is invalid or expired. Regenerate in betterness.ai dashboard.
- **404 User not found**: Using correct user ID? Check Memory.md for format.
- **503 Service unavailable**: Betterness API is temporarily down. Wait 5 minutes and retry.

## Workspace File Inventory

| File | Purpose | Owner |
|------|---------|-------|
| **README.md** | This file. Overview and quick start. | You |
| **AGENTS.md** | 6 specialist routing roles and escalation rules | Chief of Staff |
| **MCP.md** | Betterness MCP wiring, tool categories, rate limits | Your ops |
| **MEMORY.md** | User context template + operator state template | Persistent |
| **SOUL.md** | Voice, tone, core principles for the workspace | You (set once) |
| **COMMUNITY-CONTRIBUTION.md** | How to package and share custom overlays | Contributors |
| **prompts/morning-review.md** | Daily health operations check (copyable prompt) | Chief of Staff |
| **prompts/lab-gap-review.md** | Biomarker staleness detection (copyable prompt) | Biomarker Analyst |
| **prompts/weekly-operator-review.md** | Coordination prompt (copyable prompt) | Chief of Staff |
| **workflows/install-checklist.md** | Post-install verification by tool category | You (first time) |
| **workflows/private-clinic-buildout.md** | Phase 1/2/3 guide for clinic-style workspaces | Clinic builders |
| **personas/clinic-chief-of-staff.md** | Coordinator role: routes queries, escalates, reviews | Routed to for admin |
| **personas/attia-inspired-longevity-strategist.md** | Longevity role: protocols, biomarker interpretation | Routed for strategy |
| **personas/marathon-performance-coach.md** | Performance role: training load, recovery, HRV | Routed for athletes |
| **personas/biomarker-analyst.md** | Labs role: marker interpretation, panel design | Routed for lab gaps |
| **personas/lab-coordinator.md** | Operations role: ordering, status, logistics | Routed for ordering |
| **personas/nutrition-environment-operator.md** | Nutrition role: protocols, food data, env factors | Routed for nutrition |
| **components/daily-brief-panel.json** | Panel spec: sleep, HRV, recovery, action item | Display |
| **components/lab-ops-panel.json** | Panel spec: latest results, stale, pending, next | Display |
| **components/clinic-squad-board.json** | Panel spec: specialist grid, last action, pending | Display |
| **examples/openclaw-workspace-template.json** | Reference OpenClaw workspace structure | Reference |

## Install Order

Follow these steps in order. Expect **25–40 minutes** for first complete install.

### Step 1: Authentication (5 min)
1. Create Betterness account at https://betterness.ai
2. Go to Settings → MCP Keys
3. Generate a Bearer token
4. Copy to Clawbot integration config

### Step 2: Verify Connection (5 min)
1. Read [MCP.md](MCP.md) → "First 3 Tools to Test"
2. Execute each tool in Clawbot
3. Verify all three return data without errors
4. Save token if not already stored

### Step 3: Load Memory Templates (5 min)
1. Read [MEMORY.md](MEMORY.md)
2. Copy user context template into Clawbot workspace memory
3. Fill in: health goals, device list, recent lab dates
4. Copy operator context template
5. Save to workspace persistent storage

### Step 4: Load Workspace Soul (3 min)
1. Read [SOUL.md](SOUL.md)
2. Decide: which tone/principles fit your use case?
3. Copy soul text to Clawbot workspace instructions
4. (Optional) customize for your context

### Step 5: Run Smoke Tests (5 min)
1. Follow "Smoke Test" section above
2. All three tools should return data
3. If not, debug using Troubleshooting section
4. Document any issues in workspace notes

### Step 6: Add Chief of Staff Persona (3 min)
1. Read `personas/clinic-chief-of-staff.md`
2. Copy persona text into Clawbot specialist assignment
3. Assign as default router for health queries
4. Test with a simple health question

### Step 7: Run First Prompt (5 min)
1. Read `prompts/morning-review.md`
2. Copy prompt text into Clawbot message
3. Execute
4. Review output for accuracy
5. Save output to memory

### Step 8: Review Specialist Roster (2 min)
1. Read [AGENTS.md](AGENTS.md)
2. Load other 5 specialist personas as needed for your use case
3. Set up routing rules per AGENTS.md

### Step 9: Run Workflow Verification (5 min)
1. Read `workflows/install-checklist.md`
2. Run each tool category test
3. Mark green light items complete
4. Plan next features

### Step 10: Deploy First Version (Varies)
Choose one path:
- **Personal health**: Add to your daily routine
- **Private clinic**: Follow `workflows/private-clinic-buildout.md` Phase 1
- **Business operator**: Customize personas and panels per your service

## Installation Patterns

### Pattern 1: Personal Health (Solo)

You're tracking your own health metrics with wearables and occasional labs.

**Install subset**:
- ✅ Chief of Staff (does everything)
- ✅ Longevity Strategist (if interested in aging protocols)
- ✅ Lab Coordinator (minimal; mostly reference)
- ✅ Daily-brief-panel.json only
- Tools: getUserProfile, listConnectedDevices, getUserLabData, searchBiomarkers

**Time**: 15 minutes. Start with morning-review.md prompt daily.

### Pattern 2: Private Clinic (5–50 Patients)

You're running a small clinic with multiple practitioners (coaches, MDs, nutritionists).

**Install full**:
- ✅ All 6 specialists (load personas)
- ✅ All 3 panels (daily-brief, lab-ops, squad-board)
- ✅ Follow `workflows/private-clinic-buildout.md` exactly
- ✅ Set up shared Memory.md per patient
- Tools: All 26 tools (especially patient mgmt, lab ordering, payments)

**Time**: 45 minutes. Start with Phase 1 buildout workflow.

### Pattern 3: Business Operator (100+ Users, Multi-Client)

You're offering health services to many clients (corporate wellness, online coaching).

**Install full + customization**:
- ✅ All 6 specialists
- ✅ Custom personas: add your service-specific overlay (see COMMUNITY-CONTRIBUTION.md)
- ✅ Duplicate clinic buildout for each client/cohort
- ✅ Lab ordering automation (connect payment system)
- ✅ Set up escalation rules per service tier
- Tools: All 26 tools, plus custom integrations (Stripe for payment, Slack for notifications)

**Time**: 2–3 hours initial setup. 30 min per new client after.

## Troubleshooting

### Token is Invalid (401 Unauthorized)

**Symptom**: All MCP calls return 401.

**Fix**:
1. Go to betterness.ai → Settings → MCP Keys
2. Click "Regenerate" on the token
3. Copy new token
4. Update Clawbot config: `BETTERNESS_MCP_TOKEN=Bearer <NEW_TOKEN>`
5. Retry MCP call

### No Devices Returned (Empty List)

**Symptom**: `listConnectedDevices` returns empty array.

**Causes**:
- User has not connected any wearables to Betterness account
- User ID in Memory.md is wrong

**Fix**:
1. Check user ID format in Memory.md (should be UUIDv4, e.g., `a1b2c3d4-e5f6-7890-abcd-ef1234567890`)
2. Log into betterness.ai and verify user has connected devices
3. If not, connect a device first (Whoop, Oura, Fitbit, etc.)
4. Retry `listConnectedDevices`

### No Lab Data Returned (Empty List)

**Symptom**: `getUserLabData` returns empty array.

**Causes**:
- User has no lab history in Betterness
- Lab panel has not been ordered yet

**Fix**:
1. User must first order and complete a lab panel
2. Panels take 5–7 business days to process
3. Once results are back, retry `getUserLabData`

**For testing**: Create test labs using `createLabData` tool (admin only). Ask Betterness support for test fixtures.

### Rate Limiting (429 Too Many Requests)

**Symptom**: After running 10+ tools in quick succession, some calls return 429.

**Cause**: Betterness MCP has per-minute rate limits (50 calls/min per token).

**Fix**:
1. Wait 60 seconds before retrying
2. Batch tool calls: run 5, wait 10 sec, run 5 more
3. Use caching in memory for frequently accessed data
4. For high-volume needs, contact Betterness for enterprise tier

### Specialist Is Not Responding

**Symptom**: You assign a prompt to a specialist persona, but no response.

**Likely cause**: Clawbot is waiting for specialist assignment or the persona file is missing.

**Fix**:
1. Verify persona file exists in `personas/` directory
2. Check Clawbot logs for errors
3. Manually run the prompt with Chief of Staff to debug
4. Ensure specialist has access to required MCP tools

## Support

**Technical issues**:
- [Betterness MCP Docs](https://docs.betterness.ai/mcp)
- Email: api-support@betterness.ai

**Clawbot/OpenClaw issues**:
- [OpenClaw Docs](https://docs.openclaw.ai)
- Community: OpenClaw Slack #health-mission-control

**Starter kit feedback**:
- [GitHub Discussions](https://github.com/betterness-ai/starter-kits/discussions)
- Email: operations@betterness.ai

## Limitations

### Current (Use As-Is)
- **Device data lag**: Most wearables sync every 4–6 hours. Morning review will show yesterday's metrics, not real-time.
- **Lab turnaround**: Panels take 5–7 business days. Gap detection works on historical data only.
- **Single user context**: Each workspace handles one user/patient. For clinics, replicate workspace per patient.
- **No alerts/notifications**: Workflows are manual trigger only. Heartbeat (proactive alerts) coming Q2 2026.

### Coming Soon (Q2 2026)
- Heartbeat scheduler: Automated prompts on schedule (daily morning brief, weekly rollup)
- Multi-client workspace: Single workspace managing 50+ patients with role-based access
- Whoop/Oura sync: Real-time device data via webhooks
- Advanced lab ordering: Connected payment and insurance verification

### Out of Scope
- **Medical diagnosis**: This workspace augments clinical care; it is not a replacement.
- **Rx prescriptions**: Lab orders use over-the-counter panels only.
- **HIPAA hosting**: For clinical use, consult Betterness compliance team about BAA.
- **Third-party devices**: Currently supports Whoop, Oura, Fitbit, Apple Watch, Garmin. Others can be added on request.

---

**Version**: 1.0
**Last Updated**: March 2026
**Maintainer**: Betterness Operations
