# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowingsUserShow, type: :component do
  let(:following) { create(:user) }

  it 'renders the followings' do
    render_inline(FollowingsUserShow::Component.new(followings: [following]))

    expect(page).to have_content(following.username)
  end

  it 'when no following renders the folloings' do
    render_inline(FollowingsUserShow::Component.new(followings: []))

    expect(page).to have_content('まだフォローはしていません')
  end
end
