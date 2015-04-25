json.responders do
  json.array! @responders, :emergency_code, :type, :name, :capacity, :on_duty
end
