class MailingListsController < ApplicationController
  before_action :set_mailing_list, only: [:show, :edit, :update, :destroy]

  # GET /mailing_lists
  # GET /mailing_lists.json
  def index
    @mailing_lists = MailingList.all
  end

  # GET /mailing_lists/1
  # GET /mailing_lists/1.json
  def show
    @threads = EmailThread.search(@mailing_list.name)
  end

  # PATCH/PUT /mailing_lists/1
  # PATCH/PUT /mailing_lists/1.json
  def update
    respond_to do |format|
      if @mailing_list.update(mailing_list_params)
        format.html { redirect_to @mailing_list, notice: 'Mailing list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mailing_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    @threads = EmailThread.search(params[:query])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mailing_list
      @mailing_list = MailingList.where(name: params[:name] + "@mit.edu").first!
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mailing_list_params
      params.require(:mailing_list).permit(:name)
    end
end
