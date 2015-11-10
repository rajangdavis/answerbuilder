class Answer < ActiveRecord::Base
	belongs_to :user
	has_many :steps

	def self.steps
		steps = Steps.where("answer @> ARRAY[?]::integer[]", self.id)
		steps.reverse
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
