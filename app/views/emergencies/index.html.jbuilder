json.emergencies do
  json.array! @emergencies, :code, :medical_severity, :police_severity, :fire_severity
end

json.full_responses [Emergency.full_response_count, Emergency.count]
