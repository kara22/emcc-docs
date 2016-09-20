class Document < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :tagline, presence: true , uniqueness: true
validates :category, inclusion: { in: %w(fiche_technique template suivi_materiel_assurances suivi_materiel_dma rapport_hebdomadaire suivi_personnel_export ),
    message: "%{value} is not a valid category" }
end
