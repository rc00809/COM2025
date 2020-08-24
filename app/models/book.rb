class Book < ApplicationRecord
  has_one_attached :tn
  belongs_to :user
  has_many :libs
  has_many :added_books, through: :libs, source: :user
end
