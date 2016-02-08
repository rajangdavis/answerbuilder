json.extract! @answer, :series, :title, :tagline
json.steps @answer.steps, :step_type, :number, :offset, :clean_step, :image_upload