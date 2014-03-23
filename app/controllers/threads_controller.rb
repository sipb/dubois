class ThreadsController < ApplicationController
  before_action :set_thread, only: [:show]
  before_action :mailing_list, only: [:show]
  before_action :set_markdown, only: [:show]

  def show
    @replies = @thread.messages[1..-1]
  end

  def search
    @threads = EmailThread.for_mailing_list(mailing_list: mailing_list.name, name: params[:query])
    render 'search', layout: "application"
  end

  private

    def set_thread
      @thread = EmailThread.find(params[:id])
    end

    def mailing_list
      @mailing_list = MailingList.where("lower(name) = ?", params[:name] + "@mit.edu".downcase).first || @thread.mailing_list 
    end

    def set_markdown
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    end

end
