class AddColumnToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :notification, :string
  end
end
