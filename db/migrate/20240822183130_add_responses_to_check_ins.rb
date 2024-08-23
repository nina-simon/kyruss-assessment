class AddResponsesToCheckIns < ActiveRecord::Migration[6.1]
  def change
    add_column :check_ins, :responses, :jsonb, null: false, default: '{}'
    add_index :check_ins, :responses, using: :gin
  end
end
