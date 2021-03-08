# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(name: "Trottel", email: "trottel@donner.at", password: "Donner", password_confirmation: "Donner")
UrOrgUser.create(user_id: user.id, name: user.name, email: user.email)
