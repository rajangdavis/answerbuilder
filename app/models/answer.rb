class Answer < ActiveRecord::Base
	belongs_to :user
	has_many :steps

	def self.steps
		@steps = Step.where(:answer_id => self.id).order(:number,:updated_at)
	end

	def steps
		steps = []
		@steps = Step.where(:answer_id => self.id).order(:number,:updated_at)
		if self.translation_needed.match('COMPLETE')
			@steps.each_with_index do |step,i|
				steps.push({
				:step_id => step.id,
				:number => step.number, :true_number => i, :step_type => step.step_type, :step => step.step, 
				:step_jp => if step.step_jp.blank? then nil else step.step_jp end, 
				:image_jp => step.image_upload_jp,
				:image => if step.image_upload.blank? then '//'+step.image else step.image_upload end
				})
			end
		elsif self.translation_needed.match('NO')
			@steps.each_with_index do |step,i|
				steps.push({
				:step_id => step.id,
				:number => step.number, :true_number => i, :step_type => step.step_type, :step => step.step,
				:image => if step.image_upload.blank? then '//'+step.image else step.image_upload end
				})
			end
		end
		steps
	end

	def pojo2
		steps = []
		@steps = Step.where(:answer_id => self.id).order(:number,:updated_at)
		if self.translation_needed.match('COMPLETE')
			@steps.each_with_index do |step,i|
				steps.push({:number => step.number, :true_number => i, :step_type => step.step_type, :step => step.clean_step, 
				:step_id => step.id,
				:step_jp => if step.step_jp.blank? then nil else step.clean_step_jp end, 
				:image_jp => step.image_upload_jp,
				:image => if step.image_upload.blank? then '//'+step.image else step.image_upload end
				})
			end
			answer = {
				:series => self.series, :title => self.title, :tagline => self.clean_tagline,
				:title_jp => self.title_jp, :tagline_jp => self.clean_tagline_jp, :steps => steps
			}
		elsif self.translation_needed.match('NO')
			@steps.each_with_index do |step,i|
				steps.push({:number => step.number, :true_number => i, :step_type => step.step_type, :step => step.clean_step, 
				:step_id => step.id,
				:image => if step.image_upload.blank? then '//'+step.image else step.image_upload end
				})
			end
			answer = {
				:series => self.series, :title => self.title, :tagline => self.clean_tagline,
				:steps => steps
			}
		end
		answer
	end

	def pojo
		steps = []
		@steps = Step.where(:answer_id => self.id).order(:number,:updated_at)
		@steps.each_with_index do |step,i|
			steps.push({:number => step.number, :true_number => i, :step_type => step.step_type, :step => step.clean_step, 
			:step_jp => if step.step_jp.blank? then nil else step.clean_step_jp end, 
			:image_jp => step.image_upload_jp,
			:image => if step.image_upload.blank? then '//'+step.image else step.image_upload end
			})
		end
		answer = {
			:series => self.series, :title => self.title, :tagline => self.clean_tagline,
			:title_jp => self.title_jp, :tagline_jp => self.clean_tagline_jp, :steps => steps
		}
		answer
	end

	def clean_tagline
		clean_tagline = self.tagline.gsub(/\[red\]/,'<span class="red">').gsub(/\[\/red\]/,'</span>').gsub(/\[blue\]/,'<span class="blue">').gsub(/\[\/blue\]/,'</span>').gsub(/\[green\]/,'<span class="green">').gsub(/\[\/reen\]/,'</span>').gsub(/\[yellow\]/,'<span class="yellow">').gsub(/\[\/yellow\]/,'</span>').gsub(/\[orange\]/,'<span class="orange">').gsub(/\[\/orange\]/,'</span>').gsub(/\[lgreen\]/,'<span class="lgreen">').gsub(/\[\/lgreen\]/,'</span>').gsub(/\[bold\]/,'<strong>').gsub(/\[\/bold\]/,'</strong>').gsub(/\[i\]/,'<em>').gsub(/\[\/i\]/,'</em>').gsub(/\[u\]/,'<u>').gsub(/\[\/u\]/,'</u>').gsub(/\[br\]/,'<br>').gsub(/\[note\]/,'<div class="inst information_new"><i class="fa fa-3x fa-info-circle"></i><span information_text>').gsub(/\[\/note\]/,'</span></div>').gsub(/\[cat\]/,'<div class="inst cautiondiv_new"><i class="fa fa-3x fa-exclamation-triangle"></i>').gsub(/\[\/cat\]/,'</div>').gsub(/(https|http):\/\/qsee.custhelp.com/,'')

		clean_tagline = video_clean(clean_tagline)

		clean_tagline = clean_tagline.html_safe
		clean_tagline
	end

	def clean_tagline_jp
		if self.tagline_jp.blank?
			clean_tagline = nil
		else
			clean_tagline = self.tagline_jp.gsub(/\[red\]/,'<span class="red">').gsub(/\[\/red\]/,'</span>').gsub(/\[blue\]/,'<span class="blue">').gsub(/\[\/blue\]/,'</span>').gsub(/\[green\]/,'<span class="green">').gsub(/\[\/reen\]/,'</span>').gsub(/\[yellow\]/,'<span class="yellow">').gsub(/\[\/yellow\]/,'</span>').gsub(/\[orange\]/,'<span class="orange">').gsub(/\[\/orange\]/,'</span>').gsub(/\[lgreen\]/,'<span class="lgreen">').gsub(/\[\/lgreen\]/,'</span>').gsub(/\[bold\]/,'<strong>').gsub(/\[\/bold\]/,'</strong>').gsub(/\[i\]/,'<em>').gsub(/\[\/i\]/,'</em>').gsub(/\[u\]/,'<u>').gsub(/\[\/u\]/,'</u>').gsub(/\[br\]/,'<br>').gsub(/\[note\]/,'<div class="inst information_new"><i class="fa fa-3x fa-info-circle"></i><span information_text>').gsub(/\[\/note\]/,'</span></div>').gsub(/\[cat\]/,'<div class="inst cautiondiv_new"><i class="fa fa-3x fa-exclamation-triangle"></i>').gsub(/\[\/cat\]/,'</div>').gsub(/(https|http):\/\/qsee.custhelp.com/,'')	
			clean_tagline = clean_tagline.html_safe
		end
		clean_tagline
	end

	def clean_tagline_fr
		if self.tagline_fr.blank?
			clean_tagline = nil
		else
			clean_tagline = self.tagline_fr.gsub(/\[red\]/,'<span class="red">').gsub(/\[\/red\]/,'</span>').gsub(/\[blue\]/,'<span class="blue">').gsub(/\[\/blue\]/,'</span>').gsub(/\[green\]/,'<span class="green">').gsub(/\[\/reen\]/,'</span>').gsub(/\[yellow\]/,'<span class="yellow">').gsub(/\[\/yellow\]/,'</span>').gsub(/\[orange\]/,'<span class="orange">').gsub(/\[\/orange\]/,'</span>').gsub(/\[lgreen\]/,'<span class="lgreen">').gsub(/\[\/lgreen\]/,'</span>').gsub(/\[bold\]/,'<strong>').gsub(/\[\/bold\]/,'</strong>').gsub(/\[i\]/,'<em>').gsub(/\[\/i\]/,'</em>').gsub(/\[u\]/,'<u>').gsub(/\[\/u\]/,'</u>').gsub(/\[br\]/,'<br>').gsub(/\[note\]/,'<div class="inst information_new"><i class="fa fa-3x fa-info-circle"></i><span information_text>').gsub(/\[\/note\]/,'</span></div>').gsub(/\[cat\]/,'<div class="inst cautiondiv_new"><i class="fa fa-3x fa-exclamation-triangle"></i>').gsub(/\[\/cat\]/,'</div>').gsub(/(https|http):\/\/qsee.custhelp.com/,'')
			clean_tagline = clean_tagline.html_safe
		end
		clean_tagline
	end

	def video_clean(input)
		video_file = input.match('filename="(.*?)"').to_s.gsub(/filename=/,'').gsub(/"/,'')

		video_folder = input.match('folder="(.*?)"').to_s.gsub(/folder=/,'').gsub(/"/,'')

		video_html = input.gsub(/\[video /,'<div class="text-center embed-responsive embed-responsive-16by9">')

		video_html = video_html.gsub(/filename="(.*?)"/,'')

		video_html = video_html.gsub(/folder="(.*?)"/,'<video class="embed-responsive-item" controls="controls" autoplay="autoplay" poster="'+video_folder+'html5video/'+video_file+'.jpg" style="width:100%" title="recoverpassword" loop="loop" onended="var v=this;setTimeout(function(){v.play()},300)"><source src="'+video_folder+'html5video/'+video_file+'.m4v" type="video/mp4" /><source src="'+video_folder+'html5video/'+video_file+'.webm" type="video/webm" /><source src="'+video_folder+'html5video/'+video_file+'.ogv" type="video/ogg" /><source src="'+video_folder+'html5video/'+video_file+'.mp4" />')

		video_html = video_html.gsub(/\]/,'</video></div>').html_safe

		video_html
	end

	def word_count
		# count = 0
		# count += self.tagline.split.size
		# count += self.title.split.size
		# self.steps.each do |step|
		# 	count += step.step.split.size
		# end
		# count
	end

	def clean_word_count
		# count = 0

		# clean_tagline = HTML::FullSanitizer.new.sanitize(self.tagline)
		# count += clean_tagline.split.size
		# count += self.title.split.size
		# self.steps.each do |step|
		# 	clean_step = HTML::FullSanitizer.new.sanitize(step.step)
		# 	count += clean_step.split.size
		# end
		# count
	end

	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |answer|
	      csv << answer.attributes.values_at(*column_names)
	    end
	  end
	end
end
