class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # POST /users or /users.json
  def create
    if CreateUser.new(user_params).execute
      render :json: @photo, status: :ok
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      render :json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user ||= User.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :adddress, :role)
    end
    
end

class CreateUser

  attr_accessor :user_params
  DEFAULT_ROLE_NAME = 'normal_user'
  

  roles = [
    {
      role_name: 'admin'
      id: 1
    },
    {
      role_name: DEFAULT_ROLE_NAME
      id: 2
    }
  ]
  
  def initialize(user, user_params)
    @user_params = user_params
  end

  def user
    @user ||= User.new(user_params)
  end

  def execute
    city_zip_code_regexp = /^[^,\\]+[,\\\s]+(.+?)\s*(\d{5})?$/
    city = city_zip_code_regexp.match(user_params[:address])[1]
    user.city = city
    zip_code = city_zip_code_regexp.match(user_params[:address])[2]
    user.zip_code = zip_code
    user.role_id = get_user_role_id
    user.save
  end

  def get_user_role_id(role_name = DEFAULT_ROLE_NAME)
    role_record = roles.find do |role|
      role[:name] == role_name
    end
    role_record[:id] || basic_role_id
  end

  def basic_role_id
    role_record = roles.find do |role|
      role[:name] == DEFAULT_ROLE_NAME
    end[:id]
  end
end
