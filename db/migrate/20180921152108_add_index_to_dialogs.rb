class AddIndexToDialogs < ActiveRecord::Migration[5.2]
  def change
    add_index :dialogs, :name, unique: true
  end
end
