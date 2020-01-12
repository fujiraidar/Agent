class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|

      t.integer :user_id
      t.integer :engineer_id
      t.timestamps
    end
  end
end
