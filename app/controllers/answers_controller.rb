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
		@hideMe = true
	end

	def qtpojo
		@qtpojo = []
		@qtpojo.push({"device" => "Instructions using the NVR/DVR","categories"=>[{
				"label"=>"Firmware Upgrade","answers"=>[{ 
					"Generic Firmware Instructions for NVR/DVR"=>Answer.find(140).pojo }], 
				"label"=>"Setup a Schedule","answers"=>[{ 
				  	"24/7 Recording"=>Answer.find(109).pojo, 
				  	"Motion Detection"=>Answer.find(107).pojo, 
				  	"Sensitivity & Zones"=>Answer.find(221).pojo
				  	 }], 
				"label"=>"Email Notification","answers"=>[{ 
				  	"Email Notification Instructions"=>Answer.find(194).pojo }], 
				"label"=>"Playback","answers"=>[{ 
				  	"Playback Instructions"=>Answer.find(225).pojo 
				  	}], 
				"label"=>"Backup","answers"=>[{ 
				  	"Backup Instructions"=>Answer.find(228).pojo 
				  	}], 
				"label"=>"Audio / Mic Setup","answers"=>[{ 
				  	"Instructions for DVR"=>Answer.find(232).pojo, 
				  	"Instructions for NVR"=>Answer.find(231).pojo 
				  	}], 
			  	"label"=>"PTZ Setup","answers"=>[{ 
			  	  	"Add PTZ"=>Answer.find(233).pojo, 
			  	  	"Configure Cruise"=>Answer.find(135).pojo }] 
			  	}]
			},
			{"device" => "Instructions using the Browser","categories"=>[{ 
				"label"=>"Firmware Upgrade","answers"=>[{ 
					"Generic Firmware Instructions for Browser"=>Answer.find(121).pojo, 
					"Uninstall Plug-ins for PC"=>Answer.find(117).pojo, 
					"Uninstall Plug-ins for OSX"=>Answer.find(13).pojo }], 
				"label"=>"Setup a Schedule","answers"=>[{ 
				 	"24/7 Recording"=>Answer.find(223).pojo, 
				 	"Motion Detection"=>Answer.find(222).pojo, 
				 	"Sensitivity & Zones"=>Answer.find(224).pojo
				 	 }], 
				"label"=>"Email Notification","answers"=>[{ 
				 	"Email Notification Instructions for the browser"=>Answer.find(195).pojo}], 
				"label"=>"Playback","answers"=>[{ 
				 	"Windows via Browser"=>Answer.find(226).pojo 
				 	}], 
				"label"=>"Backup","answers"=>[{ 
				 	"Windows via Browser"=>Answer.find(229).pojo, 
				 	"OSX via Browser"=>Answer.find(230).pojo 
				 	}], 
				"label"=>"PTZ Setup","answers"=>[{ 
					"Add PTZ"=>Answer.find(236).pojo, 
				 	"Configure Cruise"=>Answer.find(238).pojo 
				 	}] 
				}]
			}, 
			{"device" => "Instructions using the Mobile App", "categories"=>[ {
				"label"=>"Email Notification","answers"=>[{ 
					"iPhone Email Notification Instructions"=>Answer.find(199).pojo, 
					"iPad Email Notification Instructions"=>Answer.find(196).pojo, 
					"Android Phone Email Notification Instructions"=>Answer.find(197).pojo, 
					"Android Tablet Email Notification Instructions"=>Answer.find(196).pojo }], 
				"label"=>"Playback","answers"=>[{ 
				 	"iPhone Playback Instructions"=>Answer.find(44).pojo, 
				 	"iPad Playback Instructions"=>Answer.find(46).pojo, 
				 	"Android Phone Playback Instructions"=>Answer.find(43).pojo, 
				 	"Android Tablet Playback Instructions"=>Answer.find(52).pojo }] 
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