class SuspensionsController < ActionController::Base
  def create
    user_ids = params.permit(users: []).fetch(:users, [])

    User.suspend!(user_ids)
    
    head :no_content
  end
end
