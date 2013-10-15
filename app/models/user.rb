class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessor :validate_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email_format: true
  validates :password, presence: true, if: :validate_password
  validates :snack_credits, numericality: true
  validates :drink_credits, numericality: true

  def purchase_drink
    self.update_attribute(:drink_credits, self[:drink_credits] - 1)
  end

  def purchase_snack
    self.update_attribute(:snack_credits, self[:snack_credits] - 1)
  end

end
