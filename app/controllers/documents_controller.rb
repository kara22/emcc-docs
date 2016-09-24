class DocumentsController < ApplicationController

before_action :find_document, only: [:show, :edit, :update, :destroy]


  def index
    if params[:category]
      @documents = Document.where(category: params[:category])
    else
    @documents = Document.all
    end
  end

  def show
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.user = current_user
    if @document.save
        redirect_to documents_path
    else
        render :new
    end
  end

  def edit
  end

  def update
      if @document.user == current_user
      @document.update(document_params)
      redirect_to documents_path
    else
       flash[:alert] = "Edition impossible, ce produit n'est pas le vôtre..."
       redirect_to documents_path
    end
  end

  def destroy
    if @document.user == current_user
     @document.destroy
     redirect_to documents_path
    else
      flash[:alert] = "Suppression impossible, ce produit n'est pas le vôtre..."
      redirect_to documents_path
    end

  end


private

  def document_params
    params.require(:document).permit(:name, :tagline, :category, :url)
  end

  def find_document
  @document = Document.find(params[:id])
  end


end


