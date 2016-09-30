class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @today = Time.now.strftime("%d/%m/%Y")
  end

  def team
   @users = User.all.order(:email)
  end


end
