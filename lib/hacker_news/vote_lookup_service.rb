module HackerNews
  class VoteLookupService

    attr_reader :user, :votable
    def initialize(user, votable)
      @user = user
      @votable = votable
    end

    def vote
      if @vote ||= Vote.find_by(user_id: user.id, votable: votable, votable_type: votable.class.to_s)
        @vote
      else
        nil
      end
    end

  end
end
