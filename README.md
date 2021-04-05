Rails Contexts
====
A demonstration of polymorphic associations and dynamic context-setting through meta-programming in Rails. We use a generic CRUD environment modeled after a question-and-answer database with users, tags, questions, answers, comments, and votes.

### Dynamic Contexts

Contexts are set dynamically:

	def update
	  set_contexts
	
	  if @answer.update(answer_params)
	    redirect_to dyn_question_path(@context, @id, 	@answer.question), notice: 'Answer updated.'
	  else
	    render :edit
	  end
	end
	
    def set_contexts(array = default_contexts)
      array.each do |ctxt|
        if params["#{ctxt}_id".intern]
          @context = ctxt
          @id = params["#{ctxt}_id".intern]
          return
        end
      end

      @context = :none
    end

Paths are organized by helpers:

	def dyn_receiver(context, id, answer)
	  get_context(context,
	    user:  -> { [User.find(id), answer] },
	    tag:   -> { [Tag.find(id), answer] },
	    none:  -> { answer }
	  )
	end

	def get_context(context, hash)
	  hash.each { |ctxt, lmbd| return lmbd.call if context == ctxt }
	end

### Polymorphism

Associations are polymorphic. Questions, answers, comments, and votes are all interpreted as `items`:

	class Answer < ActiveRecord::Base
		belongs_to 	:user
		belongs_to 	:question
		has_many 		:comments, 	as: :item
		has_many 		:votes,			as: :item
	end

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
