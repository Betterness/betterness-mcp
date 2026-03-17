# MCP Response Fixtures

Test fixtures for the install and refresh skills. These are recorded from a real Betterness account (PII scrubbed) and replayed during tests.

## Recording new fixtures

1. Set `BETTERNESS_TOKEN` environment variable
2. Run: `npm run test:record` (hits live MCP, saves responses)
3. Scrub PII: replace real name with "Test User", email with "test@example.com"
4. Commit the updated fixtures

## Fixture files

| File | MCP Tool | Description |
|------|----------|-------------|
| `getUserProfile.json` | getUserProfile | User identity, goals, preferences |
| `getProfileStats.json` | getProfileStats | Age, gender, location, health summary |
| `listConnectedDevices.json` | listConnectedDevices | Connected wearables with sync status |
| `getUserHealthData.json` | getUserHealthData | Recent sleep, HRV, activity metrics |
| `getUserLabData.json` | getUserLabData | Lab panels and results |
| `getBiologicalAge.json` | getBiologicalAge | Bio age score and trend |
| `flagOutOfRangeMarkers.json` | flagOutOfRangeMarkers | Out-of-range biomarkers |
| `searchBiomarkers.json` | searchBiomarkers | Biomarker search results (smoke test) |

## Error fixtures

| File | Simulates |
|------|-----------|
| `error-401.json` | Invalid/expired token |
| `error-429.json` | Rate limit exceeded |
| `error-500.json` | Server error |
| `error-timeout.json` | Request timeout |
| `empty-devices.json` | User with no connected devices |
| `empty-labs.json` | User with no lab results |
| `empty-health.json` | User with no health data |
