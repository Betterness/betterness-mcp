# Module: Equipment Tracker

Tracks chain wear, tire mileage, bike fit intervals, and service status based on actual distance logged.

## When Active
Shown when any component is within 10% of its service interval, or when the rider asks about equipment status.

## Data Sources
- Betterness Graph: equipment wear predictions based on distance, conditions, and historical replacement patterns
- Local memory: equipment log (chain install date/distance, tire install date/distance, last bike fit, last full service)

## Output
Component status with distance since last replacement, estimated remaining life, and specific action if service is due. Example: "Chain: 3,200 mi — replace now. Worn chains damage cassettes."
