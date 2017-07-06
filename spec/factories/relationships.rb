FactoryGirl.define do
  factory :relationship do
    follower_id User.first.id
    followed_id User.first.id
  end
end
