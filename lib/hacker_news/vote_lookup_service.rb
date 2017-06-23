module HackerNews
  class VoteLookupService

    attr_reader :user, :votable
    def initialize(user:, votable: nil, votable_id: nil, votable_type: nil)
      @user = user
      @votable = votable || votable_type.to_s.safe_constantize.try(:find_by, id: votable_id)
    end

    def vote
      @vote ||= Vote.find_by(user_id: user.id, votable: votable, votable_type: votable.class.to_s)
    end

    def create_vote
      if vote.nil? && votable
        @user.votes.create(votable_type: @votable.class.to_s, votable_id: @votable.id)
      end
    end

    def delete_vote(id)
      @user.votes.find_by(id: id).try(:destroy)
    end

    def links
      links = @user.votes.map(&:votable).select { |votable| votable.is_a?(Link) }
    end

  end
end
