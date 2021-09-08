require 'rails_helper'
RSpec.describe 'ユーザー登録のテスト', type: :system do
  before do
    @user = FactoryBot.create(:user,name: 'user01', email: 'user01@test.com')
    @second_user = FactoryBot.create(:second_user,name: 'user02', email: 'user02@test.com')
    FactoryBot.create(:task, user:@user)
  end
  describe 'ユーザーの新規登録' do
    context 'ユーザの新規登録ができること' do
      it 'ユーザが新規登録される' do
        visit new_user_path
        fill_in 'user[name]', with: 'user01'
        fill_in 'user[email]', with: 'user03@test.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on '登録'
        expect(page).to have_content 'user01'
      end
    end
  end
  describe 'ログインせずにタスク一覧画面に飛ぼうとした時、ログイン画面に遷移する' do
    context 'ログインせずにタスク一覧画面に飛ぼうとした時、ログイン画面に遷移する' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'ログインができること' do
      it 'ログインができること' do
        visit new_session_path
        fill_in 'session[email]', with: 'user01@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        expect(page).to have_content 'ログインしました'
      end
    end
    context '自分の詳細ページに飛ぶ' do
      it '自分の詳細ページに飛ぶ' do
        visit new_session_path
        fill_in 'session[email]', with: 'user01@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        expect(page).to have_content 'のページ'
      end
    end
    context 'ログアウトした場合' do 
      it 'ログアウトができること' do
        visit new_session_path
        fill_in 'session[email]', with: 'user01@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        expect(page).to have_content 'ログインしました'
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理ユーザは管理画面にアクセスできること' do
      it '管理ユーザは管理画面にアクセスできること' do
        visit new_session_path
        fill_in 'session[email]', with: 'user02@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        click_link '管理画面'
        expect(page).to have_content '管理画面'
      end
    end
    context '一般ユーザは管理画面にアクセスできないこと' do
      it '一般ユーザは管理画面にアクセスできないこと' do
        visit new_session_path
        fill_in 'session[email]', with: 'user01@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
      end
    end
    context '管理ユーザはユーザーの新規登録ができる' do
      it '管理ユーザはユーザの新規登録ができること' do
        visit new_session_path
        fill_in 'session[email]', with: 'user02@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        click_link '管理画面'
        click_link '新規ユーザー作成'
        fill_in 'user[name]', with: 'admin01'
        fill_in 'user[email]', with: 'admin01@test.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button'登録'
        expect(page).to have_content 'admin01'
      end
    end
    context '管理ユーザはユーザーの詳細画面にアクセスできる' do
      it '管理ユーザはユーザーの詳細画面にアクセスできること' do
        visit new_session_path
        fill_in 'session[email]', with: 'user02@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        click_link '管理画面'
        #binding.irb
        all('.user_name')[0].click_link '詳細'
        expect(page).to have_content 'user01'
      end
    end
    context '管理ユーザはユーザーの編集画面からユーザーを編集できる' do
      it '管理ユーザはユーザーの編集画面からユーザーを編集できること' do
        visit new_session_path
        fill_in 'session[email]', with: 'user02@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        click_link '管理画面'
        all('.user_name')[0].click_link '編集'
        fill_in 'user[name]', with: 'user04'
        fill_in 'user[email]', with: 'ueer04@test.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        #binding.irb
        click_button'更新する'
        expect(page).to have_content 'ユーザーを更新しました'
      end
    end
    context '管理ユーザはユーザーの削除できる' do
      it '管理ユーザはユーザーの削除できること' do
        visit new_session_path
        fill_in 'session[email]', with: 'user02@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        click_link '管理画面'
        all('.user_name')[0].click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '削除しました'
      end
    end
  end
end