require 'rails_helper'

RSpec.describe 'Admin', type: :request do
  let(:admin) { create(:admin_user) }
  let_it_be(:user) { create(:user) }
  let_it_be(:bean) { create(:bean, user: user) }


  describe 'BeanReview' do
    before do
      user
      sign_in admin
    end

    it 'created resource' do
      expect do
        post admin_beans_path, params: { bean: attributes_for(:bean, user_id: user.id) }
      end.to change(Bean, :count).by 1
    end
  end
end