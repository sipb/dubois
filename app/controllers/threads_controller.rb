class ThreadsController < ApplicationController
  before_action :set_thread, only: [:show]
  before_action :set_markdown, only: [:show]

  def show
    @replies = @thread.messages[1..-1]
  end

  private

    def set_thread
      @thread = EmailThread.find(params[:id])
    end

    def set_markdown
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    end

end
