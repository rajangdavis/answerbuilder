json.array! @answers do |answer|
	json.answer_id answer.id
	json.rn_a_id  answer.rightnow_answer_id
end