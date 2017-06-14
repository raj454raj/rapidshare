class DocumentsController < ApplicationController
  include DocumentsHelper

  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
    send_file(full_path(@document.storedfile_name),
              type: @document.documenttype,
              filename: @document.documentname)
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_path }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    update_params = {:documentname => params[:document][:documentname]}
    if params["document"]["file"]
      File.delete(full_path(@document.storedfile_name))
      update_params[:storedfile_name] = upload_file(params["document"]["file"])
    end
    @document.update_attributes(update_params)
    redirect_to documents_path
  end

  def destroy
    @document = Document.find(params[:id])
    # Delete the file from filesystem
    File.delete(full_path(@document.storedfile_name))
    # Delete the corresponding record from db
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url }
    end
  end

  private
    def full_path(filename)
      File.join("public/uploads", filename)
    end

    def document_params
      params.require(:document).permit(:file)
    end

    def update_document_params
      params.require(:document).permit(:file, :documentname)
    end

end