class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @relationships = current_user.following_relationships
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.follower == current_user
    redirect_to people_path
  end

  def create
    leader = User.find(params[:leader_id])
    if current_user.can_follow?(leader)
      Relationship.create(leader: params[:leader], follower: current_user) 
    end
    redirect_to people_path
  end
end
