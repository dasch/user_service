class UsersController < ActionController::Base
  def create
    user = User.new(user_params)

    if user.save
      Events.signup(user)
      render status: :created, json: user
    else
      render status: :bad_request, json: { errors: user.errors.full_messages }
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
