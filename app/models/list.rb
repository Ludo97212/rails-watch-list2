class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  belongs_to :user
  has_one_attached :photo
  validates :name, presence: true
end
