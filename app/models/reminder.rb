class Reminder < ApplicationRecord
  belongs_to :remindable, polymorphic: true
end
