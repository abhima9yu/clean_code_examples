class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  $roles = [
    {
      name: 'admin'
      id: 1
    },
    {
      name: 'basic_user'
      id: 2
    }
  ]


  # POST /users or /users.json
  # This awesome code needs to be refactored.
  def create
    @user = User.new(user_params)
    cit = /^[^,\\]+[,\\\s]+(.+?)\s*(\d{5})?$/.match(user_params[:address])[1]
    @user.city = cit
    @user.zip_code = /^[^,\\]+[,\\\s]+(.+?)\s*(\d{5})?$/.match(user_params[:address])[2]
    @user.role_id = fetch_role_id
    if @user.save
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user_data = User.find(params[:id])
    @user_data.update(photo_params)
    render :show, status: :created, location: @user_data
  end

  
  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :adddress, :role)
    end

    def add_user_role(role_name = 'basic_user')
      role_record = $roles.find do |role|
        role[:name] == role_name
      end
      role_record[:id]
    end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user_record = User.find(params[:id])
    @user_record.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
end
