class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|

      t.integer :engineer_id
      t.integer :help_id
      t.text :comment
      t.timestamps
    end
  end
end
