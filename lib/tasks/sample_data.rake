namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Employee.create!(name: "Example Employee",
                 email: "example@anex.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@anex.com"
      password  = "password"
      Employee.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end