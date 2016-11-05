
  ActionMailer::Base.delivery_method = :smtp


  ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'app57011576@heroku.com',
  :password       => '92vszbth5581',
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}

ActionMailer::Base.default charset: "utf-8"
