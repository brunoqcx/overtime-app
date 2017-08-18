namespace :notification do
  desc 'Send notification to employees asking them to log overtime or non requests'
  task sms: :environment do
    # schedule to run on sunday 5pm
    # User.all.each do |user|
    #   SmsTool.send_sms()
    # end
  end

end
