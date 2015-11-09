class AnswersController < ApplicationController
	def index
		@answers = Answer.all
		@answer = Answer.new
	end
	
	def preview
		@preview = true
	 	@answer = Answer.find(params[:id])
  		@steps = Step.where(:answer_id => @answer.id).order(:number,:updated_at)
	end	

	def code
  		@answer = Answer.find(params[:id])
  		@steps = Step.where(:answer_id => @answer.id).order(:number,:updated_at)
  	end
  	def strings
  		@preview = true
  		@answers = Answer.where(:language => "English")
  		@steps = Step.all.sort
  	end

  	def csv 
  		if params[:series]
  		  @answers = Answer.where(:language => "English").where(:series => params[:series]).order("created_at DESC")
	    else
	      @answers = Answer.where(:language => "English")
	    end
  		@hideMe = true
  		
		  respond_to do |format|
		  	format.html
		    format.csv { send_data @answers.to_csv }
		  end
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
		@step = Step.new
		@steps = Step.where(:answer_id => @answer.id).order(:number,:updated_at)
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
	    params.require(:answer).permit(:language, :series, :tagline, :title, :image, :user_id, :image_upload)
	  end
end