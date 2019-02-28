# frozen_string_literal: true

class User < ApplicationRecord

  # Other available modules are
  # :omniauthable, :timeoutable, :lockable
  devise :database_authenticatable, :registerable, :recoverable,
         :validatable, :confirmable, :trackable, :rememberable

  has_many :answers
end
