class AnswersController < ApplicationController
	def index
		@answers = Answer.find(:all, :order => 'title ASC')
		@answer = Answer.new
	end
	
	def translate_index
		@answers = Answer.where("translation_needed Like'%YES%'")
	end

	def preview
		@preview = true
	 	@answer = Answer.find(params[:id])
  		@steps = Step.where(:answer_id => @answer.id).order(:number,:updated_at)
	end	

	def show
		@answer = Answer.find(params[:id])
	end

	def answer
		@hideMe = true
		@answer = Answer.find(params[:id])
	end

	def preview_jp
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

  	def translate
  		@answer = Answer.find(params[:id])
  		@steps = Step.where(:answer_id => @answer.id)
  	end

  	def spreadsheet
  		@answers = Answer.where(:id => params[:id])
  		@steps = Step.find(:all, :order => 'number')
  		respond_to do |format|
  			format.xls
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
		@steps_count = @steps.length
	end

	def update
		@answer = Answer.find(params[:id])
	    if @answer.update(answer_params)
	    	flash[:notice] = "Answer successfully updated"
	      redirect_to :back
	    else
	      redirect_to :back
	    end
	end

	private

	  def answer_params   
	    params.require(:answer).permit(:language, :series, :tagline, :title, :image, :user_id, :image_upload, :translation_needed, :translation_status, :title_jp, :tagline_jp)
	  end
end