# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CloseRail, type: :component do
  it 'renders a close rail' do
    render_inline(CloseRail::Component.new)
    expect(page).to have_css('#close-rail')
  end
end
