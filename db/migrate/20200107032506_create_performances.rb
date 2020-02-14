class CreatePerformances < ActiveRecord::Migration[5.2]
  def change
    create_table :performances do |t|

      t.integer :language_id, null: false
      t.text :performance
      t.timestamps
    end
  end
end