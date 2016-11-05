module TravelsHelper

  def manager_demand #this code is for the manager who wants to ask a travel modification to the asker
    !@travel.valide? && current_user.full_name == @travel.manager_name
  end


  def travel_validable? #this code is for the manager who have the ability to valide the travel demand
    @travel.valide? && @manager.full_name == @travel.manager_name
  end

end
