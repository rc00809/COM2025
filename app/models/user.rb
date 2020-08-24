class User < ApplicationRecord
  # Include default devise modules. Others available are
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :books, dependent: :destroy
  has_many :libs
  has_many :library_additions, through: :libs, source: :book

  def subbed?
    stripe_subbed_id?
  end
end
