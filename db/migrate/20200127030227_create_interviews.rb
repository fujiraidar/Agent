class CreateInterviews < ActiveRecord::Migration[5.2]
  def change
    create_table :interviews do |t|

      t.integer :box_id, null: false
      t.text :message, null: false
      t.timestamps
    end
  end
end
