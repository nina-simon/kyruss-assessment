class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.references :questionnaire, null: false, foreign_key: true
      t.integer :position, null: false
      t.jsonb :options, null: false, default: '[]'
      t.timestamps
    end

    add_index :questions, :options, using: :gin
  end
end
