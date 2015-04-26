class ResponderDispatcher
  def initialize(emergency)
    @emergency = emergency
  end

  def dispatch!
    dispatch_responders(Fire, @emergency.fire_severity) if @emergency.fire_severity > 0
    dispatch_responders(Medical, @emergency.medical_severity) if @emergency.medical_severity > 0
    dispatch_responders(Police, @emergency.police_severity) if @emergency.police_severity > 0
  end

  private

  def dispatch_responders(klass, severity)
    responder = dispatch_single_responder(klass, severity)

    return @emergency.responders << responder if responder

    dispatch_multiple_responders(klass, severity)
  end

  def dispatch_single_responder(klass, severity)
    klass.available.on_duty.find_by(capacity: severity)
  end

  def dispatch_multiple_responders(klass, severity)
    responders = klass.available.on_duty.order(capacity: :desc)

    number_of_responders = 2

    while (number_of_responders <= responders.count)
      responders.combination(number_of_responders).each do |responder_array|
        responder_capacity = responder_array.collect(&:capacity).reduce(:+)

        return @emergency.responders << responder_array if responder_capacity == severity
      end

      number_of_responders += 1
    end

    dispatch_all_responders(klass)
  end

  def dispatch_all_responders(klass)
    @emergency.responders << klass.on_duty.available
  end
end
