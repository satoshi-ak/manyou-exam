FactoryBot.define do
  factory :task do
    title { 'test_title１' }
    content { 'test_content１' }
  end
  factory :second_task, class: Task do
    title { 'test_title 2' }
    content { 'test_content ２' }
  end
end
