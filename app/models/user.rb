class User < ApplicationRecord
  has_secure_password

  has_many :tasks, as: :taskable
  has_many :notes
end
