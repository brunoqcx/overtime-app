namespace :notification do
  desc 'Send notification to employees asking them to log overtime or non requests'
  task sms: :environment do
    # schedule to run on sunday 5pm
    # User.all.each do |user|
    #   SmsTool.send_sms()
    # end
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
