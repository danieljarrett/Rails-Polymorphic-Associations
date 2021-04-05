### CREATE USERS

  def gen_username(i)
    i <= 1 ?  "user#{i}" : Faker::Internet.user_name
  end

  def gen_password(i)
    i <= 1 ? '123456' : Faker::Internet.password
  end

  10.times do |i|

    User.create(
      username: gen_username(i),
      password: gen_password(i),
      # email: Faker::Internet.email
    )

  end

### CREATE TAGS

  20.times do

    Tag.create(
      topic: Faker::Lorem.sentence(word_count = 2, supplemental = false, random_words_to_add = 0)
    )

  end

  User.all.each do |user|

### CREATE QUESTIONS

    (6 + rand(7)).times do

      Question.create(
        user_id: user.id,
        title: Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 0),
        body: Faker::Lorem.sentence(word_count = 10 + rand(90), supplemental = false, random_words_to_add = 0)
      )

    end

    Question.where(user_id: user.id).each do |question|

### TAG QUESTIONS

			(2 + rand(5)).times do

				QuestionTag.create(
					question_id: question.id,
					tag_id: Tag.order("RANDOM()").first.id
				)

			end

### ANSWER QUESTIONS

      User.all.each do |user|

        if rand(3) == 2
          Answer.create(
            user_id: user.id,
            question_id: question.id,
            body: Faker::Lorem.sentence(word_count = 10 + rand(90), supplemental = false, random_words_to_add = 0)
          )
        end

### VOTE QUESTIONS

        if rand(3) == 2
          Vote.create(
            user_id: user.id,
            item_id: question.id,
            item_type: 'Question'
          )
        end

### COMMENT QUESTIONS

        if rand(3) == 2
          Comment.create(
            user_id: user.id,
            item_id: question.id,
            item_type: 'Question',
            body: Faker::Lorem.sentence(word_count = 10 + rand(90), supplemental = false, random_words_to_add = 0)
          )
        end

      end

      question.comments.each do |comment|

### SUB-COMMENT COMMENTS ON QUESTIONS

        User.all.each do |user|

          if rand(3) == 2
            Comment.create(
              user_id: user.id,
              item_id: comment.id,
              item_type: 'Comment',
              body: Faker::Lorem.sentence(word_count = 10 + rand(90), supplemental = false, random_words_to_add = 0)
            )
          end

### VOTE COMMENTS ON QUESTIONS

          if rand(3) == 2
            Vote.create(
            user_id: user.id,
            item_id: comment.id,
            item_type: 'Comment'
            )
          end

        end

      end

      question.answers.each do |answer|

### VOTE ANSWERS

        User.all.each do |user|

          if rand(3) == 2
            Vote.create(
            user_id: user.id,
            item_id: answer.id,
            item_type: 'Answer'
            )
          end

### COMMENT ANSWERS

          if rand(3) == 2
            Comment.create(
              user_id: user.id,
              item_id: answer.id,
              item_type: 'Answer',
              body: Faker::Lorem.sentence(word_count = 10 + rand(90), supplemental = false, random_words_to_add = 0)
            )
          end

        end

        answer.comments.each do |comment|

### SUB-COMMENT COMMENTS ON ANSWERS

          User.all.each do |user|

            if rand(3) == 2
              Comment.create(
                user_id: user.id,
                item_id: comment.id,
                item_type: 'Comment',
                body: Faker::Lorem.sentence(word_count = 10 + rand(90), supplemental = false, random_words_to_add = 0)
              )
            end

### VOTE COMMENTS ON ANSWERS

            if rand(3) == 2
              Vote.create(
              user_id: user.id,
              item_id: comment.id,
              item_type: 'Comment'
              )
            end

          end

        end

      end

    end

  end