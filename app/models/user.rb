class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email_format: true
  validates :password, presence: true
  validates :credits, numericality: true
end
