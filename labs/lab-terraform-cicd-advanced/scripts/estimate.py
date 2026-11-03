import json
import sys

if len(sys.argv) != 2:
    print("Usage: python estimate.py <json-file>")
    sys.exit(1)

with open(sys.argv[1], "r", encoding="utf-8") as f:
    data = json.load(f)

outputs = data.get("planned_values", {}).get("outputs", {})

cost = outputs.get("estimated_monthly_cost", {}).get("value", "N/A")
capacity = outputs.get("estimated_capacity_units", {}).get("value", "N/A")
summary = outputs.get("deployment_summary", {}).get("value", {})

print("=== ESTIMATION LOGIQUE ===")
print(f"Coût mensuel estimé : {cost}")
print(f"Capacité estimée    : {capacity}")
print(f"Résumé              : {summary}")
