FactoryBot.define do
  factory :task do
    title { 'test_title１' }
    content { 'test_content１' }
    expired_at { '2021/08/27'}
    status {"未着手"}
    priority{"高"}
  end
  factory :second_task, class: Task do
    title { 'test_title 2' }
    content { 'test_content ２' }
    expired_at { '2021/08/28'}
    status {"着手中"}
    priority{"中"}
  end
  factory :third_task, class: Task do
    title { 'test_title 3' }
    content { 'test_content 3' }
    expired_at { '2021/08/29'}
    status {"完了"}
    priority{"低"}
  end
end
