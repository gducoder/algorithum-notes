class AddDefaultValueToUserStatus < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :status, :string, :default => "On Duty"
  end
end
