class Sport < ActiveRecord::Base
  has_many :team

  validates_presence_of :name

  validates_uniqueness_of :name

  # before_save :format_parameters

  # def format_parameters
  #   self.name = self.name.downcase.split(' ').map{|word| word.capitalize}.join(' ')
  # end
end