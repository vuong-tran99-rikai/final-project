require 'faker'
# User.create!(name: 'admin',
#              email: 'admin@example.com',
#              password: 'admin',
#              password_confirmation: 'admin',
#              status: :opened,
#              type_account: :admin
#             )


# 99.times do |n|
#   name = Faker::Name.name
#   email = "example-#{n + 1}@railstutorial.org"
#   password = 'password'
#   User.create!(name: name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                status: 0,
#                type_account: 0
#               )
# end

99.times do |n|
  name = Faker::Book.title
  description = Faker::Lorem.paragraph
  author = Faker::Book.author
  img = 'https://toplist.vn/images/800px/khong-gia-dinh-hector-malot-441164.jpg'
  Book.create!(name_book: name,
               description: description,
               author: author,
               quantity: 10,
               price: 100000,
               image: img,
               category_id: 1,
               status: 1
              )
end
