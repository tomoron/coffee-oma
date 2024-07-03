# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumb, type: :component do
  it 'renders a breadcrumb' do
    render_inline(Breadcrumb::Component.new(path: :root))
    expect(page).to have_css('#breadcrumb')
  end
end
