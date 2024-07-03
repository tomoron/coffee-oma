# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  icon                   :string(255)
#  profile                :text(65535)
#  provider               :string(255)      default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  tokens                 :text(65535)
#  uid                    :string(255)      default(""), not null
#  unconfirmed_email      :string(255)
#  username               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  include OverwriteDevise

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy, inverse_of: 'user'
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :likes, dependent: :destroy
  has_many :bean_likes, dependent: :destroy
  has_many :product_likes, dependent: :destroy
  has_many :product_review_likes, dependent: :destroy
  has_many :bean_review_likes, dependent: :destroy
  has_many :participant1_rooms, class_name: 'Room', foreign_key: 'participant1_id', dependent: :destroy, inverse_of: 'participant1'
  has_many :participant2_rooms, class_name: 'Room', foreign_key: 'participant2_id', dependent: :destroy, inverse_of: 'participant2'
  has_many :messages, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :beans, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bean_reviews, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :username, presence: true
  mount_uploader :icon, IconUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable, :async

  def following?(other_user)
    followings.include?(other_user)
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confitmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end

  def self.find_user(user_id)
    User.includes(relationships: :follow).find(user_id)
  end

  def create_or_update_history(params)
    history = case params[:controller]
              when 'products'
                histories.find_or_create_by(product_id: params[:id])
              when 'beans'
                histories.find_or_create_by(bean_id: params[:id])
              else
                return nil
              end
    history.update(updated_at: Time.zone.now)
    history
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.username = 'ゲストユーザー'
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.zone.now
    end
  end

  def where_review_likes(reviews, like_type)
    case like_type
    when 'review'
      product_review_likes.where(liked_id: reviews.map(&:id))
    when 'bean_review'
      bean_review_likes.where(liked_id: reviews.map(&:id))
    else
      []
    end
  end

  def token_validation_response
    as_json(except: %i[tokens updated_at provider uid allow_password_change])
  end
end
