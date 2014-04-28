module MailingListsHelper

  def toggle_follower_for(mailing_list_id)
    if Follower.where(mailing_list_id: mailing_list_id, user_id: current_user.id).count > 0
      :delete
    else
      :post
    end
  end

end
