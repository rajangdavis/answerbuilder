class Step < ActiveRecord::Base
	belongs_to :answer
	has_attached_file :image_upload
	has_attached_file :image_upload_jp
	validates_attachment_content_type :image_upload, :content_type => /\Aimage\/.*\Z/
	validates_attachment_content_type :image_upload_jp, :content_type => /\Aimage\/.*\Z/
	validates_presence_of :number, :offset

	def step_number
		true_step_number = self.number - self.offset
		true_step_number
	end	

	def translatable
		ans = Answer.find(self.answer_id)
		if ans.translation_needed == "NO"
			false
		else
			true
		end
	end

	def clean_step
		clean_step = self.step.gsub(/\[red\]/,'<span class="red">').gsub(/\[red\]/,'<span class="red">').gsub(/\[\/red\]/,'</span>').gsub(/\[blue\]/,'<span class="blue">').gsub(/\[\/blue\]/,'</span>').gsub(/\[green\]/,'<span class="green">').gsub(/\[\/reen\]/,'</span>').gsub(/\[yellow\]/,'<span class="yellow">').gsub(/\[\/yellow\]/,'</span>').gsub(/\[orange\]/,'<span class="orange">').gsub(/\[\/orange\]/,'</span>').gsub(/\[lgreen\]/,'<span class="lgreen">').gsub(/\[\/lgreen\]/,'</span>').gsub(/\[bold\]/,'<strong>').gsub(/\[\/bold\]/,'</strong>').gsub(/\[i\]/,'<em>').gsub(/\[\/i\]/,'</em>').gsub(/\[u\]/,'<u>').gsub(/\[\/u\]/,'</u>').gsub(/\[br\]/,'<br>').gsub(/\[note\]/,'<div class="inst information_new"><i class="pull-left fa fa-3x fa-info-circle"></i><span information_text>').gsub(/\[\/note\]/,'</span></div>').gsub(/\[cat\]/,'<div class="inst cautiondiv_new"><i class="pull-left fa fa-3x fa-exclamation-triangle"></i>').gsub(/\[\/cat\]/,'</div>')
		clean_step = clean_step.html_safe
		clean_step
	end

	def clean_step_jp
		clean_step = self.step_jp.gsub(/\[red\]/,'<span class="red">').gsub(/\[red\]/,'<span class="red">').gsub(/\[\/red\]/,'</span>').gsub(/\[blue\]/,'<span class="blue">').gsub(/\[\/blue\]/,'</span>').gsub(/\[green\]/,'<span class="green">').gsub(/\[\/reen\]/,'</span>').gsub(/\[yellow\]/,'<span class="yellow">').gsub(/\[\/yellow\]/,'</span>').gsub(/\[orange\]/,'<span class="orange">').gsub(/\[\/orange\]/,'</span>').gsub(/\[lgreen\]/,'<span class="lgreen">').gsub(/\[\/lgreen\]/,'</span>').gsub(/\[bold\]/,'<strong>').gsub(/\[\/bold\]/,'</strong>').gsub(/\[i\]/,'<em>').gsub(/\[\/i\]/,'</em>').gsub(/\[u\]/,'<u>').gsub(/\[\/u\]/,'</u>').gsub(/\[br\]/,'<br>').gsub(/\[note\]/,'<div class="inst information_new"><i class="pull-left fa fa-3x fa-info-circle"></i><span information_text>').gsub(/\[\/note\]/,'</span></div>').gsub(/\[cat\]/,'<div class="inst cautiondiv_new"><i class="pull-left fa fa-3x fa-exclamation-triangle"></i>').gsub(/\[\/cat\]/,'</div>')
		clean_step = clean_step.html_safe
		clean_step
	end

end