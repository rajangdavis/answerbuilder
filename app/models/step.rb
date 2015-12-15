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
		clean_step = self.step.gsub(/\[red\]/,'<span class="red">').gsub(/\[red\]/,'<span class="red">').gsub(/\[\/red\]/,'</span>').gsub(/\[blue\]/,'<span class="blue">').gsub(/\[\/blue\]/,'</span>').gsub(/\[green\]/,'<span class="green">').gsub(/\[\/reen\]/,'</span>').gsub(/\[yellow\]/,'<span class="yellow">').gsub(/\[\/yellow\]/,'</span>').gsub(/\[orange\]/,'<span class="orange">').gsub(/\[\/orange\]/,'</span>').gsub(/\[lgreen\]/,'<span class="lgreen">').gsub(/\[\/lgreen\]/,'</span>').gsub(/\[bold\]/,'<strong>').gsub(/\[\/bold\]/,'</strong>').gsub(/\[i\]/,'<em>').gsub(/\[\/i\]/,'</em>').gsub(/\[u\]/,'<u>').gsub(/\[\/u\]/,'</u>').gsub(/\[br\]/,'<br>').gsub(/\[note\]/,'<div class="inst col-md-10 col-sm-10 col-xs-10 information"><div class="col-md-12 col-sm-12 col-xs-12"><h2 class="answer"><span class="lead">').gsub(/\[\/note\]/,'</span></h2></div></div>').gsub(/\[cat\]/,'<div class="inst col-md-10 col-sm-10 col-xs-10 cautiondiv"><div class="col-md-12 col-sm-12 col-xs-12"><h2 class="answer"><span class="lead">').gsub(/\[\/cat\]/,'</span></h2></div></div>').gsub(/\[p\]/,'<p class="clear inst lead">').gsub(/\[\/p\]/,'</p>')
		clean_step = clean_step.html_safe
		clean_step
	end
end