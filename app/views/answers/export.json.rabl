collection @answers
attributes :title, :tagline, :series
child :steps, :object_root => false do
	attributes :step_number,:step_type, :step
end