# Betterness MCP Configuration and Tools

## Connection Details

**Endpoint**: `https://api.betterness.ai/mcp`
**Transport**: Streamable HTTP (required for long-running tool calls)
**Authentication**: Bearer token from betterness.ai → Settings → MCP Keys
**Example header**: `Authorization: Bearer sk_live_xxxxxxxxxxxxx`

## First 3 Tools to Test

Always run these in order to verify the workspace is connected:

### 1. getUserProfile
```
Returns: User ID, name, email, health goals, connected devices
Expected data: Basic account info
Diagnostic: If this fails (401), token is invalid. If 404, user ID is wrong.
```

### 2. listConnectedDevices
```
Returns: Array of connected wearables (Whoop, Oura, Fitbit, Apple Watch, Garmin, etc.)
Expected data: At least one device
Diagnostic: Empty array means user hasn't connected any wearables in Betterness. Not an error.
```

### 3. getUserLabData
```
Returns: Recent lab results with dates, markers, and values
Expected data: Lab panel from past 12 months
Diagnostic: Empty array means user has no lab history. This is OK; order first labs.
```

## 26 Available Tools (By Category)

### User Profile & Management
- `getUserProfile` — User identity, health goals, preferences
- `getProfileStats` — Health summary (age, gender, location)
- `updateUserProfile` — Update name, goals, contact info

### Connected Devices
- `listConnectedDevices` — All paired wearables
- `getDeviceStatus` — Last sync, battery, data freshness
- `disconnectDevice` — Remove a device from account
- `syncDeviceNow` — Force immediate sync (some devices support this)

### Health Data & Biomarkers
- `getUserHealthData` — Real-time or recent metrics (sleep, HRV, activity, resting HR)
- `getUserLabData` — All historical lab results
- `searchBiomarkers` — Query specific markers by name or category
- `listBiomarkerCategories` — All available marker types (metabolic, inflammatory, etc.)

### Lab Ordering & Management
- `searchLabPanels` — Find panels by goal (e.g., "metabolic health", "longevity")
- `getLabPanel` — Details of a specific panel (tests included, cost, turnaround)
- `createLabOrder` — Place a new lab order
- `getLabOrderStatus` — Track order from placed → sample collected → results back
- `listLabCollectionSites` — Find nearest lab where user can provide sample
- `cancelLabOrder` — Cancel pending order

### Payments & Discounts
- `getPaymentOptions` — Supported payment methods, insurance, HSA/FSA
- `applyDiscount` — Apply promo codes (e.g., CLAWBOT20 for 20% off)
- `getOrderCost` — Total cost including insurance coverage and discounts

### Biomarker Analysis (Advanced)
- `getBiologicalAge` — Calculated age based on biomarkers
- `compareBiomarkerTrends` — See how markers changed over time
- `flagOutOfRangeMarkers` — Markers currently outside healthy range
- `getBiomarkerReference` — Learn what a marker means, optimal ranges, what influences it

### Admin Only (Not Available in Standard Kit)
- `createLabData` — Seed test data (admin only)
- `deleteUserData` — Remove user account (admin only)

## Tool Categories and Recommended Use

### Always Use These First (Foundation)
1. **getUserProfile** — Learn user health goals
2. **listConnectedDevices** — See what data is available
3. **getUserLabData** — Get baseline health picture

### Daily Use (Mission Control)
- **getUserHealthData** → For morning review (sleep, HRV, recovery)
- **listConnectedDevices** → Verify devices are syncing
- **getUserLabData** + **searchBiomarkers** → Weekly check-in

### Lab Operations
- **searchBiomarkers** + **listBiomarkerCategories** → Identify gaps
- **searchLabPanels** → Find right test panel
- **getPaymentOptions** + **applyDiscount** → Calculate cost with CLAWBOT20
- **createLabOrder** → Place order
- **getLabOrderStatus** → Track progress

### Advanced (Optional, Specialist Use)
- **getBiologicalAge** — Longevity Strategist
- **compareBiomarkerTrends** — Biomarker Analyst
- **flagOutOfRangeMarkers** → Alert on abnormal markers

## Behavioral Rules (Non-Negotiable)

### Data Integrity
1. **Never fabricate health data**: If a tool returns empty, say so. Don't invent data.
2. **Always cite sources**: "Based on your Whoop data from March 8..." not "probably..."
3. **Respect tool limits**: If a tool doesn't exist, don't simulate it. Escalate to human.

### Safety & Privacy
1. **Medical claims require MDs**: "You should see a doctor about this" if it's outside our scope.
2. **No diagnosis claims**: "Your insulin is high" is OK. "You have prediabetes" requires MD.
3. **Always verify consent**: Don't order labs, apply discounts, or update profile without explicit approval.

### Performance
1. **Batch calls when possible**: Run related tools in sequence, not one at a time.
2. **Cache when appropriate**: Don't call getUserLabData 10x in one workflow.
3. **Respect rate limits**: 50 calls/minute per token. If you hit 429, wait 60 sec before retry.

### Integration Integrity
1. **Betterness.ai is the source of truth**: It owns records, devices, labs, payments.
2. **Mission Control is the operator layer**: We coordinate, interpret, and route. We don't replace Betterness.
3. **Keep lines clear**: "This biomarker is low" (MCP). "Try magnesium" (planning, not Betterness action).

## High-Value Workflows

### Morning Review (5 min)
```
1. getUserHealthData (sleep, HRV, recovery score)
2. listConnectedDevices (verify sync)
3. Assess readiness
4. Output: 3-line summary + 1 action
```

### Weekly Biomarker Check (10 min)
```
1. getUserLabData (get most recent panel)
2. searchBiomarkers (look for out-of-range markers)
3. flagOutOfRangeMarkers (identify what matters)
4. Output: Issues identified + next panel recommendation
```

### Lab Ordering (15 min)
```
1. searchBiomarkers (see what's missing)
2. searchLabPanels (find right panel)
3. getPaymentOptions + applyDiscount (CLAWBOT20)
4. createLabOrder (place it)
5. listLabCollectionSites (where to go)
Output: Order placed + collection location + timeline
```

### Monthly Coordinator Review (20 min)
```
1. getUserProfile (remind self of user goals)
2. listConnectedDevices (device status)
3. getUserLabData (overall trend)
4. compareBiomarkerTrends (what's changing)
5. Output: Status summary + 2–3 strategic actions
```

## Rate Limits & Optimization

- **Per-minute**: 50 calls/min per token (burst OK, but throttle if sustained)
- **Per-day**: No daily limit (but be respectful with admin tools)
- **Timeout**: 30 seconds per call. Long operations may need retry logic.

If you get 429 (Too Many Requests):
1. Wait 60 seconds
2. Retry the failed call
3. For future: batch related calls, space out workflow execution

## Common Errors & Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| 401 Unauthorized | Token invalid/expired | Regenerate at betterness.ai/mcp/keys |
| 404 Not Found | Wrong user ID or tool doesn't exist | Check Memory.md for user ID format |
| 500 Server Error | Betterness API issue | Wait 5 min, retry. If persists, contact support. |
| 429 Too Many Requests | Rate limit hit | Wait 60 sec, then retry. Batch future calls. |
| Empty array (tools, devices, labs) | User has no data | Not an error. User needs to onboard data first. |

---

**Version**: 1.0
**Last Updated**: March 2026
**Betterness API Docs**: https://docs.betterness.ai/mcp
