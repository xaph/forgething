namespace :daily do
  desc "run daily tasks"
  task :daily, :needs => :environment do
    User.all.each do |user|
    	TodoMailer.daily_email(user).deliver
    	puts "mail sent for #{user.email}"
    end
  end
end