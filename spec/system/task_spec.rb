require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
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

  describe '検索機能' do
    before do
      FactoryBot.create(:task,title:  "task")
      FactoryBot.create(:second_task, title:"task2")
      FactoryBot.create(:third_task, title: "task3")
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'task'
        click_on '検索' 
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select "未着手", from: "status"
        click_on '検索'
        expect(page).to have_content "未着手"
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'task'
        select "未着手", from: "status"
        click_on '検索'
        expect(page).to have_content 'task'
        expect(page).to have_content '未着手'
        sleep 10
      end
    end
  end
  describe '終了期限ソート機能' do
    context '終了期限でソートするというリンクを押すと' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        task1 = Task.create(title: '1', content: 'context1', created_at: '2021/08/27' )
        task2 = Task.create(title: '2', content: 'context2', created_at: '2021/08/28' )
        visit tasks_path
        click_on '終了期限でソートする' 
        task1 = all('.task_row')
        expect(task1[0]).to have_content '2021-08-27'
        expect(task1[1]).to have_content '2021-08-28'
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