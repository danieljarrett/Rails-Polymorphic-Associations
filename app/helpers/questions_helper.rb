module QuestionsHelper
  def dyn_questions_path(context, id)
    get_context(context,
      user:  -> { user_questions_path(User.find(id)) },
      tag:   -> { tag_questions_path(Tag.find(id)) },
      none:  -> { questions_path }
    )
  end

  def dyn_new_question_path(context, id)
    get_context(context,
      user:  -> { new_user_question_path(User.find(id)) },
      tag:   -> { new_tag_question_path(Tag.find(id)) },
      none:  -> { new_question_path }
    )
  end

  def dyn_question_path(context, id, question)
    get_context(context,
      user:  -> { user_question_path(User.find(id), question) },
      tag:   -> { tag_question_path(Tag.find(id), question) },
      none:  -> { question_path(question) }
    )
  end

  def dyn_edit_question_path(context, id, question)
    get_context(context,
      user:  -> { edit_user_question_path(User.find(id), question) },
      tag:   -> { edit_tag_question_path(Tag.find(id), question) },
      none:  -> { edit_question_path(question) }
    )
  end

  def dyn_receiver(context, id, question)
    get_context(context,
      user:  -> { [User.find(id), question] },
      tag:   -> { [Tag.find(id), question] },
      none:  -> { question }
    )
  end

  def get_context(context, hash)
    hash.each { |ctxt, lmbd| return lmbd.call if context == ctxt }
  end
end