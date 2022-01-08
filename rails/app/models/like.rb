# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  liked_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_created_at  (created_at)
#  index_likes_on_user_id     (user_id)
#
class Like < ApplicationRecord
  belongs_to :user
  has_many :notifications, dependent: :destroy

  scope :find_product_and_bean, ->(user_id) { where(["user_id = ? and type IN ('ProductLike','BeanLike')", user_id]).order(created_at: :DESC) }

  def create_notification(current_user, user_id)
    notification = current_user.create_like_notification(id, user_id, self.class.name)
    notification.save
  end

  def self.product_and_bean_likes_includes(likes)
    preloader = ActiveRecord::Associations::Preloader.new
    preloader.preload(likes.select { |i| i.type == 'BeanLike' }, :bean)
    preloader.preload(likes.select { |i| i.type == 'ProductLike' }, :product)
  end

  def self.like_includes(user_id)
    likes = find_product_and_bean(user_id)
    product_and_bean_likes_includes(likes)
    likes
  end
end
