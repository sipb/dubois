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
  end

  # GET /mailing_lists/new
  def new
    @mailing_list = MailingList.new
  end

  # GET /mailing_lists/1/edit
  def edit
  end

  # POST /mailing_lists
  # POST /mailing_lists.json
  def create
    @mailing_list = MailingList.new(mailing_list_params)

    respond_to do |format|
      if @mailing_list.save
        format.html { redirect_to @mailing_list, notice: 'Mailing list was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mailing_list }
      else
        format.html { render action: 'new' }
        format.json { render json: @mailing_list.errors, status: :unprocessable_entity }
      end
    end
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

  # DELETE /mailing_lists/1
  # DELETE /mailing_lists/1.json
  def destroy
    @mailing_list.destroy
    respond_to do |format|
      format.html { redirect_to mailing_lists_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mailing_list
      @mailing_list = MailingList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mailing_list_params
      params.require(:mailing_list).permit(:name)
    end
end
