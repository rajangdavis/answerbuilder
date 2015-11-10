collection @answers
attributes :id, :title, :tagline, :series
child :steps, :object_root => false do
	attributes :number,:step_type, :step, :image_upload, :image
end