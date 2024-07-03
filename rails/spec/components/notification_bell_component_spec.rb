# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationBell, type: :component do
  it 'renders the bell icon(check: false)' do
    render_inline(NotificationBell::Component.new(checked: false))
    expect(page).to have_css('i.bell.outline.icon')
  end

  it 'renders the bell icon(check: true)' do
    render_inline(NotificationBell::Component.new(checked: true))
    expect(page).to have_css('.new_notification')
  end
end
