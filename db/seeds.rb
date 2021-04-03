# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#user = User.create(name: "Trottel", email: "trottel@donner.at", password: "Donner", password_confirmation: "Donner")
#UrOrgUser.create(user_id: user.id, name: user.name, email: user.email)

connection = ActiveRecord::Base.connection();
connection.execute("insert into users (id, name, email, password_digest, created_at, updated_at) values
  (gen_random_uuid(), 'Hilde', 'hilde@service-b.org', '$2a$10$WzddO4UzitSVC90OXJUo6Ob81wYl6cNPGpE2Xpn3nh29Z03ubgyWC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);")
connection.execute("insert into ur_org_users (id, user_id, name, email, created_at, updated_at) values
  (gen_random_uuid(), (select id from users where email = 'hilde@service-b.org'), 'Hilde', 'hilde@service-b.org', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);")
