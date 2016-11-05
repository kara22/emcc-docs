class Travel < ApplicationRecord

  belongs_to :user


  validates :date_of_departure, presence: true
  validates :date_of_return, presence: true
  validates :days_off, presence: true
  validates :reason, presence: true, inclusion: { in: %w(Congés_payés_Expatriation Congés_payés_Caisse RTT Jour_de_Voyage_pointés_VO Récupération Jours_fériés_locaux Conventionnelle Congé_sans_solde ),
    message: "%{value} veuillez renseigner le motif de votre absence" }

  validates :manager_name, presence: true, inclusion: { in: %w(Olivier_Assemat Gervais_Bouchard Antoine_Djondo Marc_Fraillon Henri_Seynave Jean_Michel_Chevrier),
    message: "%{value} veuillez renseigner le nom de votre manager" }

  validates :site, presence: true, inclusion: {in: %w(Haiti Kingston_Jamaique Abidjan_Côte_Ivoire Kamsar_Guinée Lomé_Togo Cotonou_Bénin),
    message: "%{value} veuillez renseigner votre site d'appartenance"}

end
