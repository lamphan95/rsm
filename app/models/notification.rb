class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :event, polymorphic: true

  after_create :push_notify

  enum user_read: %i(user employer admin)

  delegate :name, :picture, to: :user, prefix: true, allow_nil: :true

  scope :order_by_created_at, ->{order created_at: :desc}

  def self.create_notification content, user_read, event, user_id
    Notification.transaction do
      Notification.create content: content, user_read: user_read,
        event: event, user_id: user_id
    end
  rescue
  end

  private

  def push_notify
    ActionCable.server.broadcast "notification_channel",
      notification: render_notification(self), list_received: list_received
  end

  def render_notification notification
    ApplicationController.renderer.render(partial: "notifications/notification", locals: {notification: notification})
  end

  def list_received
    lists_received = User.send(self.user_read).try(:ids)
    lists_received.delete(self.user_id)
    lists_received
  end
end
