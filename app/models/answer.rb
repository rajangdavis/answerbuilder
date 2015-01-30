class Answer < ActiveRecord::Base
	belongs_to :user
	has_many :steps
	validates_presence_of :number
end
