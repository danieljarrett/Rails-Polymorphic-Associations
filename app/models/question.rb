class Question < ActiveRecord::Base
	belongs_to 	:user
	has_many 		:answers
	has_many 		:comments, 			as: :item
	has_many 		:votes, 				as: :item
	has_many 		:tags, 					through: :question_tags
	has_many 		:question_tags

	attr_accessor :tagstring

	after_save  :convert_tagstring_to_tags

	def convert_tagstring_to_tags
		if tagstring
			tagstring.split(',').map(&:strip).each do |topic|
				tag = Tag.find_or_create_by(topic: topic)
				QuestionTag.find_or_create_by(question_id: id, tag_id: tag.id)
			end
		end
	end
end