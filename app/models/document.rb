class Document < ApplicationRecord


  has_attachment :fichier

  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
  validates :tagline, presence: true
  validates :category, presence: true,  inclusion: { in: %w(fiche_technique template suivi_materiel_assurances suivi_materiel_dma rapport_hebdomadaire suivi_personnel_export infos_QHSE),
    message: "%{value} N'est pas une catégorie valide" }

  def self.search(search)
  where("name LIKE ?", "%#{search.capitalize}%")

  end
end
