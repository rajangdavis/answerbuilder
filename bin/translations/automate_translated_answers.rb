require 'json'

Dir.glob('*.json') do |json_file|
  	file = File.read(json_file)
	data_hash = JSON.parse(file)
	puts "Starting to update #{data_hash['id']}"
	answer = Answer.find(data_hash['id'])
	answer.fr_title = data_hash['title']
	answer.fr_tagline = data_hash['tagline']
	answer.save!
	puts '#{answer.id} was updated'
	data_hash['steps'].each do |step_|
		step = Step.find(step_['id'])
		step.step_fr = step_['step']
		step.image_upload = step_['image']
		step.save!
		puts '#{step.id} was updated'
	end
	puts 'Answer complete'
end