class Answer < ActiveRecord::Base
	belongs_to :user
	has_many :steps

	def self.steps
		steps = Steps.where("answer @> ARRAY[?]::integer[]", self.id)
		steps = steps.order(:number,:updated_at)
	end

	def pojo
		steps = []
		reverse = self.steps.reverse!
		reverse.each do |step|
			steps.push({:number => step.number, :step_type => step.step_type, :offset => step.offset, :step => step.clean_step, :image => step.image_upload})
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
