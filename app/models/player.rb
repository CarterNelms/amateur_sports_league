class Player < ActiveRecord::Base
  has_many :memberships
  has_many :teams, through: :memberships
  has_many :sports, through: :teams

  validates_presence_of :username, :first_name, :last_name, :age, :is_male

  validates_uniqueness_of :username
end