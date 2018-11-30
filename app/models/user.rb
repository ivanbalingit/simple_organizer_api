class User < ApplicationRecord
  has_secure_password

  has_many :tasks, as: :taskable
  has_many :reminders, as: :remindable
  has_many :notes
  has_many :events
end
