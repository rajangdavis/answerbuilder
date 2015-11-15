class Answer < ActiveRecord::Base
	belongs_to :user
	has_many :steps

	def self.steps
		steps = Steps.where("answer @> ARRAY[?]::integer[]", self.id)
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

	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |answer|
	      csv << answer.attributes.values_at(*column_names)
	    end
	  end
	end
end
