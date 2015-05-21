class StepsController < ApplicationController
	def new
	    @step = Step.new
	    create
  	end
  
  def edit
    @step = Step.find(params[:id])
    
  end

  def index
    # @step= Step.all
    @step = Step.find(params[:id])
    redirect_to edit_step_path(:step)
  end

  def index2
    @answers=Answer.all
    @steps= Step.all
  end

  def update
    
    @step = Step.find(params[:id])
    if @step.update(step_params)
      redirect_to edit_answer_path(@step.answer_id)+"#"+@step.id.to_s
    else
      redirect_to :back
    end
  end

  def create

    @step = Step.new(step_params)
    if @step.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @step = Step.find(params[:id])

    @step.destroy
    redirect_to(:back)
  end
  
  
  private

  def step_params   
    params.require(:step).permit(:step_type, :number, :step, :answer_id, :image, :offset, :image_upload)
  end

end