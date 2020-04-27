class ChangeColumnToComment < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :text, :text, null: false
  end
end
