class VotesController < ApplicationController

  def create
    votable_type, votable_id = vote_params
    HackerNews::VoteLookupService.new(
      user: current_user,
      votable_id: votable_id,
      votable_type: votable_type
    ).create_vote

    redirect_back(fallback_location: root_path)
  end

  def destroy
    HackerNews::VoteLookupService.new(
      user: current_user
    ).delete_vote params[:id]

    redirect_back(fallback_location: root_path)
  end

  private

  def vote_params
    params.require([:votable_type, :votable_id])
  end

end
