class AddInterruptionAndLongBreakColumnsToPhrases < ActiveRecord::Migration[5.2]
  def change
    add_column :phrases, :is_interruption, :boolean
    add_column :phrases, :is_long_break, :boolean
  end
end
