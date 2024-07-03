# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flash, type: :component do
  it 'renders a flash message(notice)' do
    render_inline(Flash::Component.new(flash: { notice: 'notice' }))
    expect(page).to have_css('#message')
    expect(page).to have_css('.positive')
  end

  it 'renders a flash message(alert)' do
    render_inline(Flash::Component.new(flash: { alert: 'alert' }))
    expect(page).to have_css('#message')
    expect(page).to have_css('.negative')
  end
end
