class Team < ActiveRecord::Base
  belongs_to :sport
  has_many :players
  has_one :captain, :class_name => "User"
  # has_one :captain, :class_name => "User", -> {where(id: @captain_id)}

  validates_presence_of :name

  validates_uniqueness_of :name, :scope => [:sport]
end