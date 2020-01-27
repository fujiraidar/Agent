class CreateInterviews < ActiveRecord::Migration[5.2]
  def change
    create_table :interviews do |t|

      t.integer :box_id
      t.text :message
      t.timestamps
    end
  end
end
