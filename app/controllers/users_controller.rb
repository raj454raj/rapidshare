class UsersController < ApplicationController
  def index
    if user_signed_in?
      @documents = Document.where("user_id = ? OR is_public = ?",
                                  current_user.id, 1)
    else
      @documents = Document.where(is_public: true)
    end
  end
end
