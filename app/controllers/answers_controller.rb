class AnswersController < ApplicationController
	def index
		@answers = Answer.all
		@answer = Answer.new
	end
	
	def new
		@answer = Answer.new
		create
	end

	def create
		@user_id = current_user.id
    	@answer = Answer.new(answer_params)
	    if @answer.save
	      redirect_to edit_answer_path(@answer)
	    else
	      
	    end
	end

	def edit
		@answer = Answer.find(params[:id])
	end

	def update
		@answer = Answer.find(params[:id])
	    if @answer.update(answer_params)
	      redirect_to :back
	    else
	      redirect_to :back
	    end
	end

	private

	  def answer_params   
	    params.require(:answer).permit(:language, :series, :tagline, :title)
	  end
end