class Step < ActiveRecord::Base
	belongs_to :answer
	has_attached_file :image_upload
	validates_attachment_content_type :image_upload, :content_type => /\Aimage\/.*\Z/

	def step_number
		true_step_number = self.number - self.offset
		true_step_number
	end	
	def img
		if self.image_upload == "/image_uploads/original/missing.png"
			self.image
		else
			self.image_upload 
		end
	end
end
