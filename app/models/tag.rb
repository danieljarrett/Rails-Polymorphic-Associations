class Tag < ActiveRecord::Base
	has_many 		:questions, 		through: :question_tags
	has_many 		:question_tags
end