class AddJobReferenceToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :job, foreign_key: true,index:true
  end
end
