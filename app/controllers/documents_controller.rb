class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
    send_data(@document.documentname,
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
        format.html { redirect_to documents_path, notice: 'Document was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @document = Document.find(params[:id])
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url }
      # format.json { head :no_content }
    end
  end

  private
    def document_params
      params.require(:document).permit(:file)
    end
end