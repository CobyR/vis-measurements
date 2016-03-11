class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def show
    redirect_to edit_profile_path
  end

  def edit
    @user = current_user
  end

  def update user
    @user = current_user

    @user.name = user[:name]
    @user.time_zone = user[:time_zone]

    if @user.save
      flash[:success] = 'Your profile was updated successfully.'
    else
      flash[:error] = 'Your profile was not updated.'
    end

    redirect_to edit_profile_path
  end
end
