module AnswersHelper
  def dyn_new_answer_path(context, id, ref)
    get_context(context,
      user:  -> { new_user_answer_path(User.find(id), question_id: ref[:question_id]) },
      tag:   -> { new_tag_answer_path(Tag.find(id), question_id: ref[:question_id]) },
      none:  -> { new_answer_path(question_id: ref[:question_id]) }
    )
  end

  def dyn_answer_path(context, id, answer)
    get_context(context,
      user:  -> { user_answer_path(User.find(id), answer) },
      tag:   -> { tag_answer_path(Tag.find(id), answer) },
      none:  -> { answer_path(answer) }
    )
  end

  def dyn_edit_answer_path(context, id, answer)
    get_context(context,
      user:  -> { edit_user_answer_path(User.find(id), answer) },
      tag:   -> { edit_tag_answer_path(Tag.find(id), answer) },
      none:  -> { edit_answer_path(answer) }
    )
  end

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
end