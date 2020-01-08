class CreateHelps < ActiveRecord::Migration[5.2]
  def change
    create_table :helps do |t|

      t.integer :user_id, null: false
      t.string :language, null: false
      t.string :title, null: false
      t.text :help, null: false
      t.timestamps
    end
  end
end
