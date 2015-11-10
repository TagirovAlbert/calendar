class Event < ActiveRecord::Base
  scope :is_public, -> { where(public: true)}
  belongs_to :user
  validates :name, presence: true,
            length: { maximum: 25 }
end
