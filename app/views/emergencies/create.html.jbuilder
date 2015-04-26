json.emergency do
  json.extract! @emergency, :code, :fire_severity, :police_severity, :medical_severity
  json.responders @emergency.responders.collect(&:name)

  json.full_response @emergency.full_response? if @emergency.full_response?
end
