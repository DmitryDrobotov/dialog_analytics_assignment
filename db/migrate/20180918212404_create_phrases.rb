class CreatePhrases < ActiveRecord::Migration[5.2]
  def change
    create_table :phrases do |t|
      t.references :dialog, foreign_key: true
      t.string :actor
      t.integer :start_in_sec
      t.integer :end_in_sec
      t.string :content

      t.timestamps
    end
  end
end
