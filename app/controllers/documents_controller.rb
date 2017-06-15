class DocumentsController < ApplicationController
  include DocumentsHelper
  before_filter :require_user, except: [:show, :get_file]

  def index
    @documents = Document.all
  end

  def get_file
    @document = Document.find(params[:id])
    send_file(File.join("public/uploads/" + @document.user_id.to_s,
                        @document.storedfile_name),
              type: @document.documenttype,
              filename: @document.documentname)
  end

  def new
    @user = User.find(session[:user_id])
    @document = @user.documents.build
  end

  def create
    @user = User.find(session[:user_id])
    @document = @user.documents.build(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to user_home_path }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @document = @user.documents.find(params[:id])
  end

  def update
    @user = User.find(session[:user_id])
    @document = @user.documents.find(params[:id])
    update_params = {documentname: params[:document][:documentname],
                     is_public: params[:document][:is_public]}
    if params["document"]["file"]
      File.delete(full_path(@document.storedfile_name))
      update_params[:storedfile_name] = upload_file(session[:user_id],
                                                    params["document"]["file"])
    end
    @document.update_attributes(update_params)
    redirect_to user_home_path
  end

  def destroy
    @user = User.find(session[:user_id])
    @document = @user.documents.find(params[:id])
    # Delete the file from filesystem
    File.delete(full_path(@document.storedfile_name))
    # Delete the corresponding record from db
    @document.destroy
    respond_to do |format|
      format.html { redirect_to user_home_path }
    end
  end

  private

  def full_path(filename)
    File.join("public/uploads/" + session[:user_id].to_s, filename)
  end

  def document_params
    params.require(:document).permit(:file, :is_public)
  end
end