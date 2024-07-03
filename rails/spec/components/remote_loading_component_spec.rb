# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RemoteLoading, type: :component do
  it 'renders the component' do
    render_inline(RemoteLoading::Component.new)
    expect(page).to have_css('.active.inline.loader')
  end
end
