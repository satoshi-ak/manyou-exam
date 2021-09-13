require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  before do
    @user = FactoryBot.create(:user,name:'user01', email: 'user01@test.com')
    @second_user = FactoryBot.create(:second_user,name: 'label02', email: 'label02@test.com')
    FactoryBot.create(:task, user:@user)
    FactoryBot.create(:label)
    FactoryBot.create(:second_label)
end
describe 'ラベルの作成機能' do
    context 'タスクを新規作成時、ラベルを選択した場合' do
      it 'タスク一覧にラベル表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'user01@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        click_link '新規登録'
        fill_in 'タイトル', with: 'title'
        fill_in '内容', with: 'content'
        select '2021', from: 'task_expired_at_1i'
        select '9月', from: 'task_expired_at_2i'
        select '13', from: 'task_expired_at_3i'
        select '未着手', from: 'ステータス'
        select '中', from: '優先度'
        check 'label01'
        click_button '登録する'
        click_link '戻る'
        visit tasks_path
        expect(page).to have_content 'title'
        expect(page).to have_content 'content'
        expect(page).to have_content '未着手'
        expect(page).to have_content '中'
        expect(page).to have_content 'label01'
      end
    end
    context 'タスクを新規作成時、ラベルを複数選択した場合' do
      it 'タスク一覧に複数のラベル表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'user01@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        click_link '新規登録'
        fill_in 'タイトル', with: 'title'
        fill_in '内容', with: 'content'
        select '2021', from: 'task_expired_at_1i'
        select '9月', from: 'task_expired_at_2i'
        select '13', from: 'task_expired_at_3i'
        select '未着手', from: 'ステータス'
        select '中', from: '優先度'
        check 'label01'
        check 'label02'
        click_button '登録する'
        click_link '戻る'
        visit tasks_path
        expect(page).to have_content 'title'
        expect(page).to have_content 'content'
        expect(page).to have_content '未着手'
        expect(page).to have_content '中'
        expect(page).to have_content 'label01'
        expect(page).to have_content 'label02'
      end
    end
  end
  describe 'ラベルの検索機能' do
    context 'ラベル名で検索した場合' do
      it 'ラベル名で検索した結果が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'user01@test.com'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        click_link '新規登録'
        fill_in 'タイトル', with: 'title'
        fill_in '内容', with: 'content'
        select '2021', from: 'task_expired_at_1i'
        select '9月', from: 'task_expired_at_2i'
        select '13', from: 'task_expired_at_3i'
        select '未着手', from: 'ステータス'
        select '中', from: '優先度'
        check 'label01'
        click_button '登録する'
        #binding.irb
        click_link '戻る'
        select 'label01', from: 'label_id'
        click_button '検索'
        expect(page).to have_content 'label01'
      end
    end
  end
end