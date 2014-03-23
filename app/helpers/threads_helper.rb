module ThreadsHelper

  def render_email(email)
    raw @markdown.render(email.body)
  end

end
