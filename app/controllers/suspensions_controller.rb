class SuspensionsController < ActionController::Base
  def create
    user_ids = params.permit(users: []).fetch(:users, [])

    users = User.suspend!(user_ids)
    users.each {|user| Events.suspension!(user) }
    
    head :no_content
  end
end
