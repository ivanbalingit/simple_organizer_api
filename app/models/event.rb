class Event < ApplicationRecord
  belongs_to :user
  has_many :tasks, as: :taskable
end
