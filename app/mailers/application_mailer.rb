class ApplicationMailer < ActionMailer::Base
  default from: 'imane.nahmed@vinci-construction.fr'

  def notify(user)
    mail(to: user.email, subject: "Votre demande de congé")
  end
end
