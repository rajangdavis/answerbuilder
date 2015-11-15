class Step < ActiveRecord::Base
	belongs_to :answer
	has_attached_file :image_upload
	validates_attachment_content_type :image_upload, :content_type => /\Aimage\/.*\Z/
	validates_presence_of :number, :offset

	def step_number
		true_step_number = self.number - self.offset
		true_step_number
	end	
end
