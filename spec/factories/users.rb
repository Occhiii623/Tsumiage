FactoryBot.define do
  
  factory :user do
    nickname              {"てすとまん"}
    icon                  {File.open("#{Rails.root}/public/images/fallback/default.jpg")}
    email                 {"kkk@gmail.com"}
    password              {"11223344"}
    password_confirmation {"11223344"}
    introduction          {"日々の積み上げをつぶやきます！"}
    URL                   {"https://www.google.co.jp/"}
  end

end