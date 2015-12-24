class Answer < ActiveRecord::Base
	belongs_to :user
	has_many :steps

	def self.steps
		@steps = Step.where(:answer_id => self.id).order(:number,:updated_at)
	end

	def pojo
		steps = []
		@steps = Step.where(:answer_id => self.id).order(:number,:updated_at)
		@steps.each_with_index do |step,i|
			steps.push({:number => step.number, :true_number => i, :step_type => step.step_type, :step => step.clean_step, 
			:image => if step.image_upload.blank? then '//'+step.image else step.image_upload end})
		end
		answer = {:series => self.series, :title => self.title, :steps => steps, :tagline => self.clean_tagline}
		answer
	end

	def clean_tagline
		clean_tagline = self.tagline.gsub(/\[red\]/,'<span class="red">').gsub(/\[red\]/,'<span class="red">').gsub(/\[\/red\]/,'</span>').gsub(/\[blue\]/,'<span class="blue">').gsub(/\[\/blue\]/,'</span>').gsub(/\[green\]/,'<span class="green">').gsub(/\[\/reen\]/,'</span>').gsub(/\[yellow\]/,'<span class="yellow">').gsub(/\[\/yellow\]/,'</span>').gsub(/\[orange\]/,'<span class="orange">').gsub(/\[\/orange\]/,'</span>').gsub(/\[lgreen\]/,'<span class="lgreen">').gsub(/\[\/lgreen\]/,'</span>').gsub(/\[bold\]/,'<strong>').gsub(/\[\/bold\]/,'</strong>').gsub(/\[i\]/,'<em>').gsub(/\[\/i\]/,'</em>').gsub(/\[u\]/,'<u>').gsub(/\[\/u\]/,'</u>').gsub(/\[br\]/,'<br>').gsub(/\[note\]/,'<div class="inst information_new"><i class="pull-left fa fa-3x fa-info-circle"></i><span information_text>').gsub(/\[\/note\]/,'</span></div>').gsub(/\[cat\]/,'<div class="inst cautiondiv_new"><i class="pull-left fa fa-3x fa-exclamation-triangle"></i>').gsub(/\[\/cat\]/,'</div>')
		clean_tagline = clean_tagline.html_safe
		clean_tagline
	end


	def word_count
		count = 0
		count += self.tagline.split.size
		count += self.title.split.size
		self.steps.each do |step|
			count += step.step.split.size
		end
		count
	end

	def clean_word_count
		count = 0

		clean_tagline = HTML::FullSanitizer.new.sanitize(self.tagline)
		count += clean_tagline.split.size
		count += self.title.split.size
		self.steps.each do |step|
			clean_step = HTML::FullSanitizer.new.sanitize(step.step)
			count += clean_step.split.size
		end
		count
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
