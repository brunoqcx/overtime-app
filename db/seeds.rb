user = User.create( email: 'test@test.com',
                    password: 'asdfasdf',
                    password_confirmation: 'asdfasdf',
                    first_name: 'bruno',
                    last_name: 'tavares',
                    phone: '2122531177')

AdminUser.create(   email: 'admin@test.com',
                    password: 'asdfasdf',
                    password_confirmation: 'asdfasdf',
                    first_name: 'admin',
                    last_name: 'tavares',
                    phone: '2122531177')

100.times do |post|
  Post.create(date: Date.today, rationale: "#{post} rationale content", user: user, overtime_request: 1.5)
end
p '100 posts created'


  AuditLog.create(user: user, status: 0, start_date:(Date.today - 6.days))
  AuditLog.create(user: user, status: 0, start_date:(Date.today - 13.days))
  AuditLog.create(user: user, status: 0, start_date:(Date.today - 20.days))


p '100 audit_logs created'
