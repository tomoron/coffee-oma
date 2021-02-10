# == Schema Information
# Schema version: 20210201071659
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
#  index_likes_on_user_id  (user_id)
#
class ProductReviewLike < Like
  belongs_to :user
  belongs_to :review, foreign_key: 'liked_id', inverse_of: :product_review_likes
  counter_culture :review, column_name: 'reviewlikes_count'
end