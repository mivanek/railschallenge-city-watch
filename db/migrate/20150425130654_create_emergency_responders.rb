class CreateEmergencyResponders < ActiveRecord::Migration
  def change
    create_table :emergency_responders do |t|
      t.belongs_to :responder
      t.belongs_to :emergency
    end
  end
end
