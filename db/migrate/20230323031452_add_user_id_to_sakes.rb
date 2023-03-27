class AddUserIdToSakes < ActiveRecord::Migration[6.1]
  def change
    add_column :sakes, :user_id, :integer
  end
end
