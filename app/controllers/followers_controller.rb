class FollowersController < ApplicationController
  before_action :require_current_user!

  def create

  end

  def destroy

  end

  private

   # Never trust parameters from the scary internet, only allow the white list through.
    def follower_params
      params.require(:id)
    end

    def require_current_user!
      @user = 
    end
end
