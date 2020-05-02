class CreateTagUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_users do |t|
      t.integer :tag_id, foreign_key: true, null: false
      t.integer :user_id, foreign_key: true, null: false
      t.timestamps
    end
  end
end
