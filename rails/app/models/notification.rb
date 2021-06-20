# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  action     :string(255)      default(""), not null
#  checked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint
#  review_id  :bigint
#  visited_id :bigint
#  visitor_id :bigint
#
# Indexes
#
#  index_notifications_on_message_id  (message_id)
#  index_notifications_on_review_id   (review_id)
#  index_notifications_on_visited_id  (visited_id)
#  index_notifications_on_visitor_id  (visitor_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (review_id => reviews.id)
#  fk_rails_...  (visited_id => users.id)
#  fk_rails_...  (visitor_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :message, optional: true
  belongs_to :review, optional: true
  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true

  default_scope -> { order(created_at: :desc) }
  scope :review_like_notifications, ->(current_user_id,user_id,id) { where(['visitor_id = ? and visited_id = ? and review_id = ? and action = ? ', current_user_id, user_id, id, 'like'])}
  scope :follow_notification, ->(current_user_id,id) {where(['visitor_id = ? and visited_id = ? and action = ?', current_user_id, id, 'follow'])}
  scope :message_notification, ->(current_user_id,user_id,id){where(
    ['visitor_id = ? and visited_id = ? and message_id = ? and action = ? ',
     current_user_id, user_id, id, 'message']
  )}
end
