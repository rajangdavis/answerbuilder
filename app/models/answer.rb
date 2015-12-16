class Answer < ActiveRecord::Base
	belongs_to :user
	has_many :steps

	def self.steps
		@steps = Step.where(:answer_id => self.id).order(:number,:updated_at)
	end

	def pojo
		steps = []
		@steps = Step.where(:answer_id => self.id).order(:number,:updated_at)
		@steps.each do |step|
			steps.push({:number => step.number, :step_type => step.step_type, :step => step.step, 
			:image => if step.image_upload.blank? then '//'+step.image else step.image_upload end})
		end
		answer = {:series => self.series, :title => self.title, :tagline => self.tagline, :steps => steps}
		answer
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
