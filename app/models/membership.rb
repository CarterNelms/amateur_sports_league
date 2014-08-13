class Membership < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  has_one :sport, through: :team

  validates_presence_of :team, :player

  # validates_uniqueness_of  :player, :scope => [:sport]
end