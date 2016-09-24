class Document < ApplicationRecord


  has_attachment :photo

  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
  validates :tagline, presence: true , uniqueness: true
  validates :category, inclusion: { in: %w(fiche_technique template suivi_materiel_assurances suivi_materiel_dma rapport_hebdomadaire suivi_personnel_export ),
    message: "%{value} N'est pas une catégorie valide" }
  validates :url, presence: true, uniqueness: true
end
