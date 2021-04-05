class Comment < ActiveRecord::Base
	belongs_to 	:user
	belongs_to 	:item, 			polymorphic: true
	has_many 		:comments, 	as: :item
	has_many 		:votes, 		as: :item

	def question
		item = self
		begin
			until item.item_type == 'Question'
				item = item.item
			end
		rescue
			return item.question
		end
		item.item
	end
end