class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :documents
  has_many :travels
  has_attachment :avatar
  has_attachment :signature

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def author?
    self.role == 'author'
  end
end
