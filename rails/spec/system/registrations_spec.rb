require 'rails_helper'

RSpec.describe 'Registrations', type: :system do
  let(:user) { create(:user) }
  let(:user1) { create(:user, email: 'test1@example.com', username: 'test2') }

  describe 'sign_up' do
    context 'when success' do
      before do
        visit new_user_registration_path
        fill_in 'user-name', with: 'test1'
        fill_in 'E-mail address', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirmation password', with: 'password'
        click_button 'Sign up'
      end

      it 'displayed message' do
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      end
    end

    context 'when fail' do
      before do
        visit new_user_registration_path
      end

      it 'password is short' do
        fill_in 'user-name', with: 'test1'
        fill_in 'E-mail address', with: 'test@example.com'
        fill_in 'Password', with: 'test'
        fill_in 'Confirmation password', with: 'test'
        click_button 'Sign up'
        expect(page).to have_current_path '/users'
      end

      it 'confirmation password is incorrect' do
        fill_in 'user-name', with: 'test1'
        fill_in 'E-mail address', with: 'test@example.com'
        fill_in 'Password', with: 'kajshdjduidj'
        fill_in 'Confirmation password', with: 'password'
        click_button 'Sign up'
        expect(page).to have_current_path '/users'
      end
    end
  end

  describe 'delete /users' do
    it 'delete seccess' do
      login(user, user.email, user.password)
      visit edit_user_registration_path
      click_on :delete_button
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
    end
  end

  describe 'get /users/edit' do
    context 'when login' do
      before do
        login(user, user.email, user.password)
        visit edit_user_registration_path
      end

      context 'when success' do
        it 'displayed icon ' do
          expect(page).to have_selector '#img-prev'
        end

        it 'change username' do
          fill_in 'spec-user-name', with: 'test'
          fill_in 'spec-E-mail address', with: user.email
          click_button 'Update'
          expect(page).to have_content 'アカウント情報を変更しました。'
        end

        it 'change email' do
          fill_in 'spec-user-name', with: 'test1'
          fill_in 'spec-E-mail address', with: 'test1@example.com'
          click_button 'Update'
          expect(page).to have_content 'アカウント情報を変更しました。'
        end

        it 'change password' do
          fill_in 'spec-password', with: 'password1'
          fill_in 'spec-password-confirmation', with: 'password1'
          click_button 'Update'
          expect(page).to have_content 'アカウント情報を変更しました。'
        end
      end

      context 'when fail' do
        it 'not change username' do
          fill_in 'spec-user-name', with: ''
          fill_in 'spec-E-mail address', with: user.email
          click_button 'Update'
          expect(page).to have_current_path '/users'
        end

        it 'not change email' do
          fill_in 'spec-user-name', with: 'test1'
          fill_in 'spec-E-mail address', with: ''
          click_button 'Update'
          expect(page).to have_current_path '/users'
        end

        it 'not change password' do
          fill_in 'spec-password', with: 'password'
          fill_in 'spec-password-confirmation', with: 'password1'
          click_button 'Update'
          expect(page).to have_current_path '/users'
        end
      end
    end
  end

  describe 'get /users/:id/show' do
    context 'when login' do
      before do
        login(user, user.email, user.password)
      end

      it 'displayed icon ' do
        visit "/users/#{user.id}/show"
        expect(page).to have_selector 'img'
      end

      it 'have link edit' do
        visit "/users/#{user.id}/show"
        expect(page).to have_link 'プロフィールを編集'
      end
    end

    context 'when not login' do
      it 'not have link edit' do
        visit "/users/#{user.id}/show"
        expect(page).to have_no_link edit_user_registration_path
      end
    end
  end
end