class Admin::BaseController < ApplicationController
    def current_user
    binding.pry
        current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
     end
end
