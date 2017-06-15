class DocumentsController < ApplicationController
  before_action :authenticate_user!, except: [:get_file]

  def index
    @documents = Document.all
  end

  def get_file
    @document = Document.find(params[:id])
    send_file(File.join("public", @document.attachment_url),
              filename: @document.name)
  end

  def new
    @document = Document.new
  end

  def create
    @user = User.find(current_user.id)
    @document = @user.documents.build(document_params)
    if @document.save
       redirect_to user_home_path, notice: "The document #{@document.name} has been uploaded."
    else
       render "new"
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @document = @user.documents.find(params[:id])
    @document.destroy
    redirect_to user_home_path, notice:  "The document #{@document.name} has been deleted."
  end

  def edit
    @user = User.find(current_user.id)
    @document = @user.documents.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    @document = @user.documents.find(params[:id])

    if params["document"]["file"]
      File.delete(File.join("public", @document.attachment_url))
      @document.attachment = params["document"]["file"]
    end
    @document.update_attributes(name: params[:document][:name],
                                is_public: params[:document][:is_public])
    redirect_to user_home_path
  end

  private

  def document_params
    params.require(:document).permit(:name, :attachment)
  end

end