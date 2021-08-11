# == Schema Information
#
# Table name: news
#
#  id            :bigint           not null, primary key
#  active        :boolean          default(FALSE)
#  content       :text(65535)
#  publicshed_at :datetime         not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_news_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => admin_users.id)
#
FactoryBot.define do
  factory :news do
    active {true}
    content {"<p>Hello world</p>"}
  end
end
