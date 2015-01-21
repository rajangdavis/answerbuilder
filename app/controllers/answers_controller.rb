class AnswersController < ApplicationController
	def index
		@answers = Answer.all
		@answer = Answer.new
	end
end