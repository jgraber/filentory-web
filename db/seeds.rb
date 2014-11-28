# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'ROLES'
puts "ENV: #{ENV['ROLES']}"
#YAML.load(ENV['ROLES']).each do |role|
#  puts role
#  Role.where(name: role).first_or_create
#  #Role.find_or_create_by_name({ :name => role }, :without_protection => true)
#  puts 'role: ' << role
#end
#Role.where(name: :admin).first_or_create
admin = Role.where(name: :admin).first_or_create
puts 'DEFAULT USERS'
user = User.where(email: Rails.application.secrets.admin_email).first_or_create :name => Rails.application.secrets.admin_name, :password => Rails.application.secrets.admin_password, :password_confirmation => Rails.application.secrets.admin_password
puts 'user: ' << user.name
user.add_role admin
