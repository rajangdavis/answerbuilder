class AnswersController < ApplicationController

	def index
		if !current_user
			redirect_to index2_path
		end
		@answers = Answer.find(:all, :order => 'title ASC')
		@answer = Answer.new
	end

	def automate
		@answer = Answer.new
		@answer.automate_answers
	end

	def index2
		if params['jp'] == 'true'
			@answers = Answer.where("translation_needed Like'%COMPLETE%'")
		elsif params['series'] =='newqt'
			@answers = Answer.where("title Like '%NEW QT%'")
		else
			@answers = Answer.find(:all, :order => 'title ASC')
		end
	end

	def index3
		@answers = Answer.find(:all, :order => 'title ASC')
	end

	def qsee_updates
	end
	
	def qsee_rn_array
		@answers = Answer.where('rightnow_answer_id IS NOT NULL')
	end

	def qsee_rn_partial
		@answer = Answer.find(params[:id])
		@steps = Step.where(:answer_id => @answer.id).order(:number,:updated_at)
		render json: { 
	       content: (render_to_string partial: 'angular_answer2', locals: {answer: answer}, layout: false )  
	    } 
	end

	def translate_index
		if !current_user
			redirect_to index2_path
		end
		@answers = Answer.where("translation_needed Like'%YES%'")
	end

	def qtpojo
		@qtpojo = []
		@qtpojo.push(
			{"device" => "Instructions using the NVR/DVR",
			"categories"=>[
				{"category"=>"Recording Setup and Configuration",
				 "answers"=>[
				 	Answer.find(109).pojo, 
				  	Answer.find(107).pojo, 
				  	Answer.find(221).pojo ]
				},
				{"category"=>"Playback",
				 "answers"=>[
				 	Answer.find(225).pojo]
				}, 
				{"category"=>"Backup",
				 "answers"=>[
				 	Answer.find(228).pojo]
				}, 
				{"category"=>"Audio / Mic Setup",
				 "answers"=>[
				 	Answer.find(232).pojo, 
				  	Answer.find(231).pojo]
				}, 
			  	{"category"=>"PTZ Setup",
			  	 "answers"=>[
			  		Answer.find(233).pojo, 
			  	  	Answer.find(235).pojo] 
			  	},
			  	{"category"=>"Firmware Upgrade",
				 "answers"=>[
				 	Answer.find(140).pojo ]
				}, 
				{"category"=>"Email Notification",
				 "answers"=>[
				 	Answer.find(194).pojo]
				}]
			},
			{"device" => "Instructions using the Browser",
			 "categories"=>[
				{"category"=>"Firmware Upgrade",
				 "answers"=>[
				 	Answer.find(121).pojo, 
					Answer.find(117).pojo, 
					Answer.find(13).pojo]
				}, 
				{"category"=>"Setup a Schedule",
				 "answers"=>[
				 	Answer.find(223).pojo, 
				 	Answer.find(222).pojo, 
				 	Answer.find(224).pojo]
				}, 
				{"category"=>"Email Notification","answers"=>[
					Answer.find(195).pojo]
				}, 
				{"category"=>"Playback","answers"=>[
					Answer.find(226).pojo]
				}, 
				{"category"=>"Backup",
				 "answers"=>[ 
				 	Answer.find(229).pojo, 
				 	Answer.find(230).pojo]
				}, 
				{"category"=>"PTZ Setup",
				 "answers"=>[ 
					Answer.find(236).pojo, 
				 	Answer.find(238).pojo] 
				}]
			},
			{"device" => "Instructions using the Mobile App", 
				"categories"=>[
				{"category"=>"Email Notification",
				 "answers"=>[
				 	Answer.find(199).pojo, 
					Answer.find(196).pojo, 
					Answer.find(197).pojo, 
					Answer.find(196).pojo]
				},
				{"category"=>"Playback",
				"answers"=>[
				 	Answer.find(44).pojo, 
				 	Answer.find(46).pojo, 
				 	Answer.find(43).pojo, 
				 	Answer.find(52).pojo] 	
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
		@steps = Step.where(:answer_id => @answer.id).order(:number,:updated_at)
	end

	def alt_answer
		@hideMe = true
		@answer = Answer.find(params[:id])
		@steps = Step.where(:answer_id => @answer.id).order(:number,:updated_at)
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

  	def code2
  		@answer = Answer.find(params[:id])
  		@steps = Step.where(:answer_id => @answer.id).order(:number,:updated_at)
  	end

  	def strings
  		@preview = true
  		@answers = Answer.where(:language => "English")
  		@steps = Step.all.sort
  	end

  	def translate
  		if !current_user
			redirect_to index2_path
		end
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
		if !current_user
			redirect_to index2_path
		end
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
	    params.require(:answer).permit(:language, :series, :tagline, :title, :image, :user_id, :image_upload, :translation_needed, :translation_status, :title_jp, :tagline_jp, :rightnow_answer_id)
	  end
end