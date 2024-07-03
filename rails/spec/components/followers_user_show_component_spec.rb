# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowersUserShow, type: :component do
  let(:follower) { create(:user) }

  it 'renders followers' do
    render_inline(FollowersUserShow::Component.new(followers: [follower]))
    expect(page).to have_content(follower.username)
  end
end
