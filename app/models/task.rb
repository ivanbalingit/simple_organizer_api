class Task < ApplicationRecord
  belongs_to :taskable, polymorphic: true
  has_many :subtasks
  has_many :reminders, as: :remindable
end
