json.emergencies do
  json.array! @emergencies, :code, :medical_severity, :police_severity, :fire_severity
end

# json.array! @emergencies, @emergencies.count
