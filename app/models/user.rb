class User < ApplicationRecord
  rolify
  has_secure_password
  
  has_many :orders, dependent: :destroy
  has_many :shipping_addresse, dependent: :destroy

  after_create :assign_default_role
  validate :must_have_a_role, on: :update
 

  private

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "must have at least 1 role")
    end
  end

end
