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

	def qtpojo
		@qtpojo = []
		@qtpojo.push(
			{"device" => "Instructions using the NVR/DVR",
			"categories"=>[
				{"category"=>"Firmware Upgrade",
				 "answers"=>[
				 	{0=>Answer.find(140).pojo }]
				}, 
				{"category"=>"Setup a Schedule",
				 "answers"=>[
				 	{0=>Answer.find(109).pojo}, 
				  	{1=>Answer.find(107).pojo}, 
				  	{2=>Answer.find(221).pojo }]
				},
				{"category"=>"Email Notification",
				 "answers"=>[
				 	{0=>Answer.find(194).pojo }]
				},
				{"category"=>"Playback",
				 "answers"=>[
				 	{0=>Answer.find(225).pojo}]
				}, 
				{"category"=>"Backup",
				 "answers"=>[
				 	{0=>Answer.find(228).pojo}]
				}, 
				{"category"=>"Audio / Mic Setup",
				 "answers"=>[
				 	{0=>Answer.find(232).pojo}, 
				  	{1=>Answer.find(231).pojo}]
				}, 
			  	{"category"=>"PTZ Setup",
			  	 "answers"=>[
			  		{0=>Answer.find(233).pojo}, 
			  	  	{1=>Answer.find(235).pojo }] 
			  	}]
			},
			{"device" => "Instructions using the Browser",
			 "categories"=>[
				{"category"=>"Firmware Upgrade",
				 "answers"=>[
				 	{0=>Answer.find(121).pojo}, 
					{1=>Answer.find(117).pojo}, 
					{2=>Answer.find(13).pojo }]
				}, 
				{"category"=>"Setup a Schedule",
				 "answers"=>[
				 	{0=>Answer.find(223).pojo}, 
				 	{1=>Answer.find(222).pojo}, 
				 	{2=>Answer.find(224).pojo}]
				}, 
				{"category"=>"Email Notification","answers"=>[
					{0=>Answer.find(195).pojo}]
				}, 
				{"category"=>"Playback","answers"=>[
					{0=>Answer.find(226).pojo }]
				}, 
				{"category"=>"Backup",
				 "answers"=>[ 
				 	{0=>Answer.find(229).pojo}, 
				 	{1=>Answer.find(230).pojo }]
				}, 
				{"category"=>"PTZ Setup",
				 "answers"=>[ 
					{0=>Answer.find(236).pojo}, 
				 	{1=>Answer.find(238).pojo}] 
				}]
			},
			{"device" => "Instructions using the Mobile App", 
				"categories"=>[
				{"category"=>"Email Notification",
				 "answers"=>[
				 	{0=>Answer.find(199).pojo}, 
					{1=>Answer.find(196).pojo}, 
					{2=>Answer.find(197).pojo}, 
					{3=>Answer.find(196).pojo}]
				},
				{"category"=>"Playback",
				"answers"=>[
				 	{0=>Answer.find(44).pojo}, 
				 	{1=>Answer.find(46).pojo}, 
				 	{2=>Answer.find(43).pojo}, 
				 	{3=>Answer.find(52).pojo}] 	
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