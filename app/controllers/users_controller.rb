class UsersController < ApplicationController

  def index
    if params[:search] && !params[:search].empty?
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.reject { |user| ApplicationHelper.obscene_substring?(user.username) }
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
