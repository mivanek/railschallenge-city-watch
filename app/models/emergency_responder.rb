class EmergencyResponder < ActiveRecord::Base
  belongs_to :responder
  belongs_to :emergency
end
