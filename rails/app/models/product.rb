# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  imageurl      :text(65535)
#  itemcaption   :text(65535)
#  itemname      :string(255)
#  itemprice     :integer
#  itemurl       :text(65535)
#  likes_count   :integer          default(0), not null
#  rate_sum      :integer          default(0), not null
#  reviews_count :integer          default(0), not null
#  shopname      :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_products_on_likes_count  (likes_count)
#  index_products_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :product_likes,
           foreign_key: 'liked_id',
           dependent: :destroy,
           inverse_of: :product
  belongs_to :user

  mount_uploader :imageurl, ImageurlUploader
  acts_as_taggable

  validates :itemname, :itemprice, :shopname, :itemcaption, presence: true

  scope :keywords_search, ->(keywords) { ransack(keywords) }
  scope :sort_by_likes_count, -> { order('likes_count desc') }

  def rate_average_num
    if reviews_count.zero?
      return 0
    end

    (rate_average * 2).floor / 2.to_f
  end

  def rate_average
    if reviews_count.zero?
      return 0
    end

    (rate_sum.to_f / reviews_count).floor(1)
  end

  def self.like_top
    Product.all.sort_by_likes_count.limit(TOP_DISPALY_NUM)
  end

  def self.tag_result(tag_name, page)
    Product.tagged_with(tag_name).page(page).per(INDEX_DISPALY_NUM)
  end

  def self.ranking_index
    Product.all.sort_by_likes_count.limit(INDEX_DISPALY_NUM)
  end
end
