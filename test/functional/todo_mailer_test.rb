require 'test_helper'

class TodoMailerTest < ActionMailer::TestCase
	def test_daily_email
		user = users(:one)

		email = TodoMailer.daily_email(user).deliver
		assert !ActionMailer::Base.deliveries.empty?

		assert_equal [user.email], email.to
	end
end
