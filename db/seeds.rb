user = User.create(email: 'test@test.com', password: 'asdfasdf', password_confirmation: 'asdfasdf', first_name: 'bruno', last_name: 'tavares')

AdminUser.create(email: 'admin@test.com', password: 'asdfasdf', password_confirmation: 'asdfasdf', first_name: 'admin', last_name: 'tavares')

100.times do |post|
  Post.create(date: Date.today, rationale: "#{post} rationale content", user: user)
end
p '100 posts created'
