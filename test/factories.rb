FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "users#{n}@example.com" }
    password "Password12345"
    password_confirmation "Password12345"
    admin false

    factory :admin_user do
      admin true
    end
  end

  factory :poll do
    sequence(:title) { |n| "Poll ##{n}" }
    question "Poll"
    association :user, factory: :admin_user

    after(:create) do |poll|
      5.times do
        create(:poll_option, poll: poll)
      end
    end
  end

  factory :poll_option do
    association :poll
    association :user
    sequence(:text) { |n| "Option #{n}" }
  end

  factory :poll_response do
    association :poll
    association :user
    association :poll_option
  end

  factory :comment do
    association :user
    association :poll
    sequence(:comment) { |n| "Comment #{n}" }
  end
end
