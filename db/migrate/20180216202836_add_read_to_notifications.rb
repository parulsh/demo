class AddReadToNotifications < ActiveRecord::Migration[5.0]
  def change
  	  add_column :notificationS, :read, :boolean, :default=> false
  end
end
