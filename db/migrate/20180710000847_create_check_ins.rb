class CreateCheckIns < ActiveRecord::Migration[5.2]
  def change
    create_table :check_ins do |t|
      t.string :patient_id, null: false
      t.timestamps
    end
  end
end
