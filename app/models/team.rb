class Team < ActiveRecord::Base
  belongs_to :sport
  has_many :memberships
  has_many :players, through: :memberships
  has_one :captain, :class_name => "Membership"

  validates_presence_of :name

  validates_uniqueness_of :name, :scope => [:sport]
end