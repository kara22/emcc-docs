class ApplicationMailer < ActionMailer::Base
  default from: 'Contact EMCC Export <imane.nahmed@vinci-construction.fr>'

  def notify(user)
    mail(to: user.email, subject: "Votre demande de congé")
  end

  def notify_manager(user)
     mail(to: user.email, subject: "Demande de congés à valider")
  end

  def manager_validation(user)
    mail(to: user.email, subject: "Votre demande de congé validée")
  end
end
