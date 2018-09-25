class AddIndices < ActiveRecord::Migration[5.2]
  def change
    add_index :dialogs, :name, unique: true
    add_index :phrases, [:dialog_id, :start_in_sec]
  end
end
