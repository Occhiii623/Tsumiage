FactoryBot.define do
  
  factory :relationship do
    association :user, factory: :user
    association :user, factory: :other_user
  end

end