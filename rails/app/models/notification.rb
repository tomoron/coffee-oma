# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  action     :string(255)      default(""), not null
#  checked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  like_id    :bigint
#  message_id :bigint
#  visited_id :bigint
#  visitor_id :bigint
#
# Indexes
#
#  index_notifications_on_checked     (checked)
#  index_notifications_on_created_at  (created_at)
#  index_notifications_on_like_id     (like_id)
#  index_notifications_on_message_id  (message_id)
#  index_notifications_on_visited_id  (visited_id)
#  index_notifications_on_visitor_id  (visitor_id)
#
# Foreign Keys
#
#  fk_rails_...  (like_id => likes.id)
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (visited_id => users.id)
#  fk_rails_...  (visitor_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :message, optional: true
  belongs_to :like, optional: true
  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true

  before_save :check_some_user?

  scope :history_order, -> { order(updated_at: :desc) }
  scope :checked_false, -> { where(checked: false) }
  scope :action_filter, ->(action) { select { |n| n.action == action } }

  def self.checked_notifications(user_id)
    user = User.find(user_id)
    user.passive_notifications.checked_false.update_all(checked: true) # rubocop:disable Rails/SkipsModelValidations
  end

  def self.follow_notification(current_user_id, follower_id)
    where(['visitor_id = ? and visited_id = ? and action = ?', current_user_id, follower_id, 'follow'])
  end

  def check_some_user?
    return unless visitor_id == visited_id

    self.checked = true
  end
end
