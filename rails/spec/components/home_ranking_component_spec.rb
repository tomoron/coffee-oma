# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeRanking, type: :component do
  let(:product) { create(:product, brand: brand) }
  let(:brand) { create(:brand) }

  it 'renders a list of rankings' do
    render_inline(HomeRanking::Component.new(rankings: [product]))

    expect(page).to have_text(product.name)
  end
end
