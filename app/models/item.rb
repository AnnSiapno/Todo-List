class Item < ApplicationRecord
  belongs_to :user

  def completed?
    !completed_at.black?
  end
end
