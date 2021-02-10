# == Schema Information
#
# Table name: bean_reviews
#
#  id                :bigint           not null, primary key
#  acidity           :integer          default(0)
#  bitter            :integer          default(0)
#  content           :text(65535)      not null
#  flavor            :integer          default(0)
#  reviewlikes_count :integer          default(0), not null
#  rich              :integer          default(0)
#  sweet             :integer          default(0)
#  title             :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  bean_id           :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_bean_reviews_on_bean_id  (bean_id)
#  index_bean_reviews_on_user_id  (user_id)
#
class BeanReview < ApplicationRecord
  has_one :recipe, dependent: :destroy
  belongs_to :bean
  belongs_to :user
  has_many :bean_review_likes,
           foreign_key: 'liked_id',
           dependent: :destroy,
           inverse_of: :bean_review
  validates :title,
            :content,
            :acidity,
            :bitter,
            :flavor,
            :rich,
            :sweet,
            presence: true
  counter_culture :bean, column_name: 'review_count'

  def like_record(liker_id)
    bean_review_likes.find_by(user_id: liker_id)
  end
end