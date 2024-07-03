# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowButton, type: :component do
  let(:user) { create(:user) }
  let(:another_user) { create(:user, :other_user) }
  let(:follow) { create(:relationship, user: user, follow: another_user) }

  it 'renders the follow button(follow exist)' do
    render_inline(FollowButton::Component.new(user: user, follow: follow))
    expect(page).to have_text('フォロー解除')
  end

  it 'renders the follow button(follow no exist)' do
    render_inline(FollowButton::Component.new(user: user, follow: nil))
    expect(page).to have_text('フォローする')
  end
end
