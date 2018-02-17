class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    html = ApplicationController.render partial: "notifications/followed", locals: {notification: notification, current_user: notification.recipient}, formats: [:html]
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: html
  end
end