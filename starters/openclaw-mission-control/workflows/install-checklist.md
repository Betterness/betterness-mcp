# Post-Installation Verification Checklist

Complete this checklist BEFORE adding personas or extending the workspace. Expected time: 30 minutes.

## Section 1: Account & Authentication (5 min)

- [ ] You have a live Betterness account (https://betterness.ai)
- [ ] You've generated an MCP Bearer token (Settings → MCP Keys)
- [ ] Token is saved in Clawbot config: `BETTERNESS_MCP_TOKEN=Bearer sk_live_xxxxx`
- [ ] You have at least one connected device OR lab data in your Betterness account

**Diagnostic**: If token is wrong, you'll get 401 errors below. Regenerate at betterness.ai/mcp/keys.

## Section 2: Core Files Installed (3 min)

- [ ] `AGENTS.md` (6 specialist roles defined)
- [ ] `MCP.md` (tool reference + behavioral rules)
- [ ] `MEMORY.md` (user context template filled in)
- [ ] `SOUL.md` (voice and principles loaded)

All four files must be present and readable by Clawbot.

## Section 3: Smoke Test — User Profile (3 min)

**Action**: In Clawbot, trigger the `getUserProfile` tool.

**Expected result**:
```
{
  "userId": "550e8400-e29b-41d4-a716-446655440000",
  "name": "[Your name]",
  "email": "[Your email]",
  "healthGoals": ["[Goal 1]", "[Goal 2]"],
  "location": "[City]"
}
```

**Troubleshooting**:
- [ ] 401 Unauthorized → Token expired. Regenerate.
- [ ] 404 Not Found → User ID wrong in MEMORY.md. Check format (UUIDv4).
- [ ] 500 Server Error → Betterness API issue. Wait 5 min, retry.

**Green Light**: ✓ getUserProfile returns your real data

## Section 4: Smoke Test — Device Connectivity (3 min)

**Action**: In Clawbot, trigger `listConnectedDevices`.

**Expected result**:
```
[
  { "deviceName": "Whoop Band", "type": "wearable", "lastSync": "2026-03-09T08:14:00Z" },
  { "deviceName": "Oura Ring", "type": "wearable", "lastSync": "2026-03-09T06:47:00Z" }
]
```

**Troubleshooting**:
- [ ] Empty array [] → User has not connected any devices. Not an error, but limits what you can see.
  - **Action**: Go to betterness.ai and connect a device (Whoop, Oura, Fitbit, Apple Watch, Garmin).
  - Once connected, retry this test.
- [ ] 403 Forbidden → Token doesn't have device access. Check token scopes in betterness.ai.
- [ ] 500 Server Error → API issue. Wait and retry.

**Green Light**: ✓ listConnectedDevices returns [at least one device] OR [] (you'll connect one later)

## Section 5: Smoke Test — Lab Data (3 min)

**Action**: In Clawbot, trigger `getUserLabData`.

**Expected result**:
```
[
  {
    "panelId": "CMP-001",
    "panelName": "Comprehensive Metabolic Panel",
    "dateOrdered": "2026-02-15",
    "dateCollected": "2026-02-20",
    "dateResultsReceived": "2026-02-28",
    "status": "Complete",
    "biomarkers": [...]
  }
]
```

**Troubleshooting**:
- [ ] Empty array [] → User has no lab history. Not an error.
  - **Action**: Order your first lab panel using the Lab Coordinator.
  - Panels take 5–7 business days. This test will pass once results arrive.
- [ ] 403 Forbidden → Token doesn't have lab access. Check token scopes.
- [ ] 500 Server Error → API issue. Wait and retry.

**Green Light**: ✓ getUserLabData returns [at least one panel] OR [] (you'll order labs later)

## Section 6: Add Core Prompts (5 min)

- [ ] **prompts/morning-review.md** — Accessible and copyable
- [ ] **prompts/lab-gap-review.md** — Accessible and copyable
- [ ] **prompts/weekly-operator-review.md** — Accessible and copyable

**Test**: Run `prompts/morning-review.md` in Clawbot. Should return a daily health brief (3-5 lines + 1 action).

**Green Light**: ✓ At least one prompt runs and returns readable output

## Section 7: Add Chief of Staff (3 min)

- [ ] Load `personas/clinic-chief-of-staff.md`
- [ ] Assign as default specialist for general health queries

**Test**: Ask Chief of Staff: "What's my health status this week?"

**Expected**: Should call listConnectedDevices + getUserLabData and give a brief summary.

**Green Light**: ✓ Chief of Staff responds with data-backed summary

## Section 8: Test Routing (5 min)

Ask each scenario; verify routing:

**Scenario 1** (Labs):
- Ask: "My insulin is high. What does that mean?"
- Expect: Routes to **Biomarker Analyst**
- [ ] Confirmed

**Scenario 2** (Performance):
- Ask: "Should I train hard today?"
- Expect: Routes to **Performance Coach**
- [ ] Confirmed

**Scenario 3** (Ordering):
- Ask: "What labs should I order?"
- Expect: Routes to **Lab Coordinator**
- [ ] Confirmed

**Scenario 4** (Coordination):
- Ask: "Give me a full health review"
- Expect: Routes to **Chief of Staff** (who may call other specialists)
- [ ] Confirmed

**Green Light**: ✓ All 4 scenarios route correctly

## Section 9: Verify Components & Panels (2 min)

- [ ] `components/daily-brief-panel.json` exists and is readable
- [ ] `components/lab-ops-panel.json` exists and is readable
- [ ] `components/clinic-squad-board.json` exists and is readable

(These are optional for Phase 1 but good to have installed.)

**Green Light**: ✓ All 3 component files present

## Section 10: Final Verification (2 min)

- [ ] All smoke tests passed (3/3)
- [ ] Chief of Staff is responding
- [ ] At least one prompt (morning-review) runs
- [ ] No critical errors in Clawbot logs

**DECISION**: Are you ready to proceed?

- **Yes** → Go to Section 11 (Expand Workspace)
- **No** → Debug the failing test; do not proceed until all green lights are lit

## Section 11: Expand Workspace (Optional — Do This Later)

Only proceed if ALL Section 1-10 checks are GREEN:

- [ ] Add remaining specialists (Longevity Strategist, Performance Coach, Biomarker Analyst, Lab Coordinator, Nutrition & Environment)
- [ ] Add custom panels if needed (see `components/`)
- [ ] Set up weekly/monthly automation (see `prompts/`)
- [ ] For clinics: Follow `private-clinic-buildout.md` next

---

**Checklist Version**: 1.0
**Date Completed**: [_______________]
**Completed By**: [_______________]
**Notes**: [_______________]
