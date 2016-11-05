class TravelsController < ApplicationController
  before_action :find_travels, only: [:show, :edit, :update, :destroy, :valide]



  def index
    if params[:site]
      @travels = Travel.all.order("created_at DESC").where(site: params[:site])
    else
      @travels = Travel.all.order("created_at DESC")
    end
  end


  def show
    @manager = User.find_by(full_name:  @travel.manager_name)
    if current_user == @travel.user || current_user.role == "manager"
    else
      flash[:alert] = "Vous ne pouvez pas voir cette demande"
      redirect_to root_path
    end
  end


  def new
    @travel = Travel.new
  end


  def create
    @travel = Travel.new(travels_params)
    @manager = User.find_by(full_name:  @travel.manager_name)
    @travel.user = current_user
    if @travel.save
        flash[:notice] = "#{@travel.user.full_name}, demande de congé est en attente de validation"
        redirect_to root_path
    else
      render :new
    end
    UserMailer.notify(current_user).deliver
    UserMailer.notify_manager(@manager).deliver
  end



  def edit
    if @travel.user == current_user && !@travel.valide? || current_user.role == "author"
    else
      flash[:alert] = "Vous n'avez pas les droits pour éditer cette demande"
      redirect_to root_path
    end
  end


  def update
    if @travel.user == current_user && !@travel.valide? || current_user.role == "author"
      @travel.update(travels_params)
      flash[:notice] = "Confirmation: #{@travel.user.full_name} vous avez édité une demande de congé"
      redirect_to root_path
    elsif @travel.user == current_user && travel.valide?
      flash[:alert] = "Votre demande a été validée donc l'édition est impossible"
      redirect_to root_path
    else
      flash[:alert] = "Vous ne pouvez pas éditer cette demande car elle a été postée par #{@travel.user.full_name}"
      redirect_to root_path
    end
  end



  def destroy
    if @travel.user == current_user || current_user.role == "author"
      @travel.destroy
      flash[:notice] = "Confirmation : #{@travel.user.full_name} vous avez bien supprimé une demande de congé"
      redirect_to root_path
    else
      flash[:alert] = "Vous ne pouvez pas supprimer cette demande car elle a été postée par #{@travel.user.full_name} "
      redirect_to root_path
    end
  end



  def valide
  @manager = User.find_by(full_name:  @travel.manager_name)

    if current_user.role == "manager" &&  @travel.manager_name == current_user.full_name
        @travel.update_attributes(valide?: true)
        flash[:notice] = "Vous avez validé une demande de congé"
        redirect_to travel_path
        UserMailer.manager_validation(@travel.user).deliver
    end
  end



  private


  def find_travels
    @travel = Travel.find(params[:id])
  end

  def travels_params
    params.require(:travel).permit(:registration_number, :service,:date_of_departure, :date_of_return, :days_off, :reason, :manager_name, :comment, :site)
  end
end
