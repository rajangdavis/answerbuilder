class AnswersController < ApplicationController
	def index
		if !current_user
			redirect_to root_path
		end
		@answers = Answer.find(:all, :order => 'title ASC')
		@answer = Answer.new
	end
	
	def translate_index
		@answers = Answer.where("translation_needed Like'%YES%'")
	end

	def manual
		
	end

	def qtpojo
		@qtpojo = []
		@qtpojo.push(
			{"Instructions using the NVR/DVR"=>[{
				"Firmware Upgrade"=>[{ 
					"Generic Firmware Instructions for NVR/DVR"=>"Answer.find(  ).pojo" }], 
				"Setup a Schedule"=>[{ 
				  	"24/7 Recording"=>"Answer.find(  ).pojo", 
				  	"Motion Detection"=>"Answer.find(  ).pojo", 
				  	"Sensitivity & Zones"=>"Answer.find(  ).pojo" }], 
				"Email Notification"=>[{ 
				  	"Email Notification Instructions"=>"Answer.find(  ).pojo" }], 
				"Playback"=>[{ 
				  	"Playback Instructions"=>"Answer.find(  ).pojo" }], 
				"Backup"=>[{ 
				  	"Backup Instructions"=>"Answer.find(  ).pojo" }], 
				"Audio / Mic Setup"=>[{ 
				  	"Instructions for DVR"=>"Answer.find(  ).pojo", 
				  	"Instructions for NVR"=>"Answer.find(  ).pojo" }], 
			  	"PTZ Setup"=>[{ 
			  	  	"Add PTZ"=>"Answer.find(  ).pojo", 
			  	  	"Configure Presets"=>"Answer.find(  ).pojo", 
			  	  	"Configure Cruise"=>"Answer.find(  ).pojo" }] 
			  	}]
			}, 
			{"Instructions using the Browser"=>[{ 
				"Firmware Upgrade"=>[{ 
					"Generic Firmware Instructions for Browser"=>"Answer.find(  ).pojo", 
					"Uninstall Plug-ins for PC"=>"Answer.find(  ).pojo", 
					"Uninstall Plug-ins for OSX"=>"Answer.find(  ).pojo" }], 
				"Setup a Schedule"=>[{ 
				 	"24/7 Recording"=>"Answer.find(  ).pojo", 
				 	"Motion Detection"=>"Answer.find(  ).pojo", 
				 	"Sensitivity & Zones"=>"Answer.find(  ).pojo" }], 
				"Email Notification"=>[{ 
				 	"Email Notification Instructions"=>"Answer.find(  ).pojo" }], 
				"Playback"=>[{ 
				 	"Windows via Browser"=>"Answer.find(  ).pojo", 
				 	"OSX via Browser"=>"Answer.find(  ).pojo" }], 
				"Backup"=>[{ 
				 	"Windows via Browser"=>"Answer.find(  ).pojo", 
				 	"OSX via Browser"=>"Answer.find(  ).pojo" }], 
				"PTZ Setup"=>[{ "Add PTZ"=>"Answer.find(  ).pojo", 
				 	"Configure Presets"=>"Answer.find(  ).pojo", 
				 	"Configure Cruise"=>"Answer.find(  ).pojo" }] 
				}]
			}, 
			{"Instructions using the Mobile App"=>[ {
				"Email Notification"=>[{ 
					"iPhone Email Notification Instructions"=>"Answer.find(  ).pojo", 
					"iPad Email Notification Instructions"=>"Answer.find(  ).pojo", 
					"Android Phone Email Notification Instructions"=>"Answer.find(  ).pojo", 
					"Android Tablet Email Notification Instructions"=>"Answer.find(  ).pojo" }], 
				"Playback"=>[{ 
				 	"iPhone Playback Instructions"=>"Answer.find(  ).pojo", 
				 	"iPad Playback Instructions"=>"Answer.find(  ).pojo", 
				 	"Android Phone Playback Instructions"=>"Answer.find(  ).pojo", 
				 	"Android Tablet Playback Instructions"=>"Answer.find(  ).pojo" }] 
				}]
		})
		render json: @qtpojo
	end

	def preview
		@preview = true
		if params['new']
			@partial2 = true
		else
			@partial2 = false
		end
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

	def answer_jp
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
	      redirect_to edit_answer_path(@answer)
	    else
	      redirect_to :back
	    end
	end

	private

	  def answer_params   
	    params.require(:answer).permit(:language, :series, :tagline, :title, :image, :user_id, :image_upload, :translation_needed, :translation_status, :title_jp, :tagline_jp)
	  end
end