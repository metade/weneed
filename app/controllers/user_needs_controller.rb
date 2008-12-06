class UserNeedsController < ApplicationController
  before_filter :login_required
  
  def edit
    @needs = Need.find(:all)
  end
  
  def update
    params[:user][:needs_ids] ||= []
    if current_user.update_attributes(params[:user])
      flash[:notice] = 'Need was successfully updated.'
      redirect_to(user_path(current_user))
    else
      render :action => "edit"
    end
  end
end
