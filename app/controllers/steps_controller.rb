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

  def update
    
    @step = Step.find(params[:id])
    if @step.update(step_params)
      redirect_to answer_path(@step.answer_id)
    else
      render 'edit'
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
    params.require(:step).permit(:type, :number, :step, :answer_id)
  end

end