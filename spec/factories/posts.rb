FactoryBot.define do
  
  factory :post do
    text        {"テストテストテストテストテストテストテストテストテストテストテストテスト"}
    image       {File.open("#{Rails.root}/public/images/fallback/default.jpg")}
    association :user, factory: :user 
  end

end