class VotesController < ApplicationController

  def create
    current_user.votes.create(votable_type: vote_params[0], votable_id: vote_params[1])

    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.votes.find_by(id: params[:id]).try(:destroy)

    redirect_back(fallback_location: root_path)
  end

  def vote_params
    params.require([:votable_type, :votable_id])
  end

end
