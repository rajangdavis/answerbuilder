class AnswersController < ApplicationController

	require "base64"
	require "digest"

	require "open-uri"

	def test

		@answer_id = params['id']

		@API_URL ='https://developer-sandbox.liondemand.com/'
		@API_ACCESS_KEY = ENV["API_ACCESS_KEY"]
		@API_SECRET = ENV["API_SECRET"]

		@resource = URI.parse(@API_URL+"api/quote/generate")
		@url = @resource.scheme + @resource.host + @resource.path

		@dateTime_firstpass = Time.now
		@dateTime = @dateTime_firstpass.iso8601(10)


		@signature_before = 'POST:' + @url + ':' + @API_SECRET + ':' + @dateTime + ':2014-06-10:application/json'
		
		@signature_base = Digest::SHA256.digest @signature_before

		@signature = Base64.encode64(@signature_base)
		

		@authorization = 'LOD1-BASE64-SHA256 KeyID=' + @API_ACCESS_KEY + ',Signature=' + @signature + ',SignedHeaders=x-lod-timestamp;x-lod-version:accept'

		
		@requestHeaders = []
		
		
		@requestHeaders.push(
		    'Accept: application/json',
		    'Authorization: ' + @authorization,
		    'Content-Type: application/json',
		    'X-LOD-VERSION: 2014-06-10',
		    'X-LOD-TIMESTAMP: ' + @dateTime
		)

		@post_body = Answer.find(@answer_id).pojo

		@c = Curl::Easy.http_post(@resource.host + @resource.path , Curl::PostField.content('POSTFIELDS',@post_body))
		# @c.version = Curl::HTTP_2_0
		@c.headers = @requestHeaders

		@c.perform

		render json: @c.body_str
	end

	def index
		if !current_user
			redirect_to index2_path
		end
		@answers = Answer.find(:all, :order => 'title ASC')
		@answer = Answer.new
	end

	def index2
		if params['jp'] == 'true'
			@answers = Answer.where("translation_needed Like'%COMPLETE%'")
		else
			@answers = Answer.find(:all, :order => 'title ASC')
		end
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
	    params.require(:answer).permit(:language, :series, :tagline, :title, :image, :user_id, :image_upload, :translation_needed, :translation_status, :title_jp, :tagline_jp)
	  end
end