class TodoMailer < ActionMailer::Base
  default from: "info@forgething.com"

  def daily_email(user)
  	@user = user
  	@starred_todos = @user.todos.starred
  	@today_todos = @user.todos.today

  	mail(:to => @user.email, :subject => "Daily Todos from forgething")
  end
end
