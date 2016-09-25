class DocumentsController < ApplicationController

before_action :find_document, only: [:show, :edit, :update, :destroy]


  def index
    if params[:category]
      @documents = Document.where(category: params[:category]).order("created_at DESC").paginate(page: params[:page], per_page: 5)
    else
    @documents = Document.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
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
      if @document.user == current_user || current_user.author?
      @document.update(document_params)
      redirect_to documents_path
    else
       flash[:alert] = "Vous n'avez pas posté ce document, donc l'édition est impossible"
       redirect_to documents_path
    end
  end

  def destroy
    if @document.user == current_user || current_user.author?
     @document.destroy
     redirect_to documents_path
    else
      flash[:alert] = "Vous n'avez pas posté ce document, donc la suppression est impossible."
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


