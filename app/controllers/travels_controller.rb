class TravelsController < ApplicationController

  def index
    if params[:site]
      @travels = Travel.all.order("created_at DESC").where(site: params[:site])
    else
      @travels = Travel.all.order("created_at DESC")
    end
end

  def show
    @travel = Travel.find(params[:id])
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
    @travel.user = current_user
      if @travel.save
        flash[:notice] = "Votre demande de congé est en attente de validation"
        redirect_to root_path
      else
        render :new
      end
  end

  def edit
    @travel = Travel.find(params[:id])
  end

  def update
    @travel = Travel.find(params[:id])
    if @travel.user == current_user && !@travel.valide?
      @travel.update(travels_params)
      flash[:notice] = "Confirmation: vous avez édité une demande de congé"
      redirect_to root_path
    elsif @travel.user == current_user && travel.valide?
      flash[:alert] = "Votre demande a été validée donc l'édition est impossible"
      redirect_to root_path
    else
      flash[:alert] = "Vous n'avez pas posté cette demande, donc l'édition est impossible"
      redirect_to root_path
    end
  end

  def destroy
  @travel = Travel.find(params[:id])
    if @travel.user == current_user
      @travel.destroy
      flash[:notice] = "Confirmation: vous avez supprimé une demande de congé"
      redirect_to root_path

    else
      flash[:alert] = "Erreur: vous n'avez pas posté cette demande, donc la supression est impossible"
      redirect_to root_path
    end
  end

  def valide
  @travel = Travel.find(params[:id])
    if current_user.role == "manager" &&  @travel.manager_name == current_user.full_name
        @travel.update_attributes(valide?: true)
        flash[:notice] = "Vous avez validé une demande de congé"
        redirect_to travel_path
    end
  end



  private

  def travels_params
    params.require(:travel).permit(:registration_number, :service,:date_of_departure, :date_of_return, :days_off, :reason, :manager_name, :comment, :site)
  end
end
