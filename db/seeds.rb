# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
Poll.delete_all
PollResponse.delete_all
PollOption.delete_all

@admin = User.create! email: "admin@example.com", password: "Admin12345", password_confirmation: "Admin12345", admin: true
@users = []
5.times do |x|
  @users << User.create!(email: "user#{x}@example.com", password: "User12345", password_confirmation: "User12345", admin: false)
end

@poll1 = Poll.create! user: @admin, question: "What's your favourite text editor?", title: "What's your favourite text editor?"
@options1 = []
@options1 << PollOption.create!(poll: @poll1, text: "Emacs")
@options1 << PollOption.create!(poll: @poll1, text: "Vim")
@options1 << PollOption.create!(poll: @poll1, text: "Spacemacs")
@options1 << PollOption.create!(poll: @poll1, text: "Something not as good")

PollResponse.create! poll: @poll1, user: @users.sample, poll_option: @options1.sample
