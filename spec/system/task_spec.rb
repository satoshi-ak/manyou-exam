require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task') }
  before do
    visit tasks_path
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task1 = Task.create(title: '1', content: 'context1', created_at: '2021/08/24' )
        task2 = Task.create(title: '2', content: 'context2', created_at: '2021/08/25' )
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '1'
        expect(task_list[1]).to have_content '2'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task,id:1)
        visit task_path(1)
        expect(page).to have_content 'test_title１'
        expect(page).to have_content 'test_content１'
      end
    end
  end
end