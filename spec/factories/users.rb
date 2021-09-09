FactoryBot.define do
  factory :user do
    name {'user01'}
    email {'user01@test.com'}
    password {'password'}
    password_confirmation {'password'}
    admin{ false }
  end
  factory :second_user, class: User do
    name {'user02'}
    email {'user02@test.com'}
    password {'password'}
    password_confirmation {'password'}
    admin{ true }
  end
  factory :third_user,class: User do
    name {'user03'}
    email {'user05@test.com'}
    password {'password'}
    password_confirmation {'password'}
    admin{ false }
  end
end
