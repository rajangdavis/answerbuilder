class Step < ActiveRecord::Base
	belongs_to :answer
	has_attached_file :image_upload
	validates_attachment_content_type :image_upload, :content_type => /\Aimage\/.*\Z/
end
