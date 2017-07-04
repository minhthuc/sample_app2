User.create! name: "Truong Minh Thuc", email: "minhthuc229@gmail.com",
  password: "5595845", password_confirmation: "5595845"

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end
