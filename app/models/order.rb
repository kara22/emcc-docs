class Order < ApplicationRecord


  belongs_to :user


  has_attachment :bon_de_commande
end
