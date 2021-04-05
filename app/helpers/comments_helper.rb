module CommentsHelper
  def dyn_new_comment_path(context, id, ref)
    get_context(context,
      user:  -> { new_user_comment_path(User.find(id), question_id: ref[:question_id], item_type: ref[:item_type], item_id: ref[:item_id]) },
      tag:   -> { new_tag_comment_path(Tag.find(id), question_id: ref[:question_id], item_type: ref[:item_type], item_id: ref[:item_id]) },
      none:  -> { new_comment_path(question_id: ref[:question_id], item_type: ref[:item_type], item_id: ref[:item_id]) }
    )
  end

  def dyn_comment_path(context, id, comment)
    get_context(context,
      user:  -> { user_comment_path(User.find(id), comment) },
      tag:   -> { tag_comment_path(Tag.find(id), comment) },
      none:  -> { comment_path(comment) }
    )
  end

  def dyn_edit_comment_path(context, id, comment)
    get_context(context,
      user:  -> { edit_user_comment_path(User.find(id), comment) },
      tag:   -> { edit_tag_comment_path(Tag.find(id), comment) },
      none:  -> { edit_comment_path(comment) }
    )
  end

  def dyn_receiver(context, id, comment)
    get_context(context,
      user:  -> { [User.find(id), comment] },
      tag:   -> { [Tag.find(id), comment] },
      none:  -> { comment }
    )
  end

  def get_context(context, hash)
    hash.each { |ctxt, lmbd| return lmbd.call if context == ctxt }
  end
end