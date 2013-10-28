class User < ActiveRecord::Base
  authenticates_with_sorcery!

  DRINK_COSTS = 0.6
  SNACK_COSTS = 0.5

  attr_accessor :validate_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email_format: true
  validates :password, presence: true, if: :validate_password
  validates :snack_credits, numericality: true
  validates :drink_credits, numericality: true

  def purchase_drink
    self.update_attribute(:drink_credits, self[:drink_credits] - 1)
  end

  def drink_to_money
    self.drink_credits * DRINK_COSTS
  end

  def purchase_snack
    self.update_attribute(:snack_credits, self[:snack_credits] - 1)
  end

  def snack_to_money
    self.snack_credits * SNACK_COSTS
  end

  def total_credits_to_money
    drink_to_money + snack_to_money
  end
end
