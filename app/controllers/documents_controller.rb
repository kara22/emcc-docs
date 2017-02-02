class DocumentsController < ApplicationController

before_action :find_document, only: [:show, :edit, :update, :destroy]


  def index
    if params[:category] == "fiche_technique"
      @documents = Document.where(category: params[:category]).order(:name)

    elsif params[:category]
      @documents = Document.where(category: params[:category]).order("created_at DESC")

    elsif params[:search]
      @documents = Document.search(params[:search]).order("created_at DESC")
    else
      @documents = Document.all.order("created_at DESC")
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
        redirect_to root_path
    else
        render :new
    end
  end

  def edit
  end

  def update
      if @document.user == current_user || current_user.author?
      @document.update(document_params)
      flash[:notice] = "Confirmation: vous avez édité un document"
      redirect_to root_path
    else
       flash[:alert] = "Vous n'avez pas posté ce document, donc l'édition est impossible"
       redirect_to root_path
    end
  end

  def destroy
    if @document.user == current_user || current_user.author?
     @document.destroy
     flash[:notice] = "Confirmation: vous avez supprimé un document"
     redirect_to root_path
    else
      flash[:alert] = "Vous n'avez pas posté ce document, donc la suppression est impossible."
      redirect_to root_path
    end

  end


private

  def document_params
    params.require(:document).permit(:name, :tagline, :category, :url, :photo)
  end

  def find_document
  @document = Document.find(params[:id])
  end




end


