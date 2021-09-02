require 'rails_helper'

describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task, title: 'task1', status: '未着手') }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'task2', status: '着手中') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        # search_result = Task.search_title('task1')
        expect(Task.search_title('task1')).to include(task)
        expect(Task.search_title('task1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('未着手')).to include(task)
        expect(Task.search_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('task1').search_status('未着手')).to include(task)
        expect(Task.search_title('task1').search_status('未着手').count).to eq 1
      end
    end
  end
end