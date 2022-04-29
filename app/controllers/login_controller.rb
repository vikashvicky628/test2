class LoginController < ApplicationController
  protect_from_forgery with: :null_session

  def initialize
    @logger
  end

  def index
    render "login"
  end

  def create
    @logger = [params[:un_form], params[:pw_form]].join(":")
    puts "[DEBUG] un:pw -> " + @logger
    render 'logged_in'
  end
end
