# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # each account has one profile
  has_one :profile, dependent: :destroy
  # each account has two roles and default role is user
  enum role: { users: 0, admin: 1 }

  protected

  def password_required?
    confirmed? ? super : false
  end
end
