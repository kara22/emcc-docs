class CreateTravels < ActiveRecord::Migration[5.0]
  def change
    create_table :travels do |t|
      t.string  :registration_number
      t.string  :service
      t.date    :date_of_departure
      t.date    :date_of_return
      t.integer :days_off
      t.string  :reason
      t.string  :comment
      t.string  :manager_name
      t.boolean :valide?,  :default => false
      t.integer :user_id


      t.timestamps
    end
  end
end
