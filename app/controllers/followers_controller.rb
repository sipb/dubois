class FollowersController < ApplicationController
  before_action :require_current_user!

  def create
    current_user.followers.create!(:mailing_list_id => follower_params)
    redirect_to request.referer
  end

  def destroy
    current_user.followers.where(:mailing_list_id => follower_params).destroy_all
    redirect_to request.referer
  end

  private

   # Never trust parameters from the scary internet, only allow the white list through.
    def follower_params
      params.require(:id)
    end

end
