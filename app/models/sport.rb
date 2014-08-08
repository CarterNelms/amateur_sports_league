class Sport < ActiveRecord::Base
  has_many :team

  validates_presence_of :name
end