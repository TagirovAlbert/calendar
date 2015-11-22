class Event < ActiveRecord::Base
  scope :is_public, -> { where(private: false)}
  belongs_to :user
  validates :name, presence: true,
            length: { maximum: 25 }
  validates :description, presence: true, length: {in: 10..100}
end
