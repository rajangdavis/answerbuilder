collection @answers
attributes :title, :tagline, :series
child :steps, :object_root => false do
	attributes :number,:step_type, :step
end