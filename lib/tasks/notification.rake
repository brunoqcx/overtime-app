namespace :notification do
  desc 'Send notification to employees asking them to log overtime or non requests'
  task sms: :environment do
    if Time.now.sunday?
      employees = Employee.all
      notificaton_message = "Please log into the overtime in: bt13overtime.com"

      employees.each do |employee|
        AuditLog.create!(user_id: employee.id)
        SmsTool.send_sms(number: employee.phone, message: notificaton_message)
      end
    end
  end

  desc 'Sends mail notification to manager each day to inform of pending overtime requests'
  task manager_email: :environment do
    submitted_posts  = Post.submitted
    admin_users = AdminUser.all

    if submitted_posts.any?
      admin_users.each do |admin|
        ManagerMailer.email(admin).deliver_now
      end
    end
  end
end
