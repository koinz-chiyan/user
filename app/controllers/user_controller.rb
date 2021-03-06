
# user controller

class UserController < ApplicationController
  def signin
    @callback_url = params[:callback_url]
  end

  def authenticate
    us = EndUser.authenticate(params[:user][:email], params[:user][:password])
    if (us) 
      # redirect_to "http://www.google.com?auth_token=#{us.auth_token}"
      redirectUrl = params[:user][:callback_url] + "/#{us.user_email}/#{us.auth_token}"
      redirect_to redirectUrl
    else
      redirect_to :action => :signin, :callback_url => params[:user][:callback_url]
    end
  end

  def signup
    @callback_url = params[:callback_url]
    endUser = EndUser.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => endUser}
    end
  end

  def create
    if request.post?
      endUser = EndUser.create(
        :email => params[:user][:email], 
        :password => params[:user][:password], 
        :first_name => params[:user][:first_name],
        :last_name => params[:user][:last_name]
      )
      if endUser
        flash[:notice] = 'User account was successfully created.'
        redirect_to :action => :signin, :callback_url => params[:user][:callback_url]
      end
    end
  end

  def authSession
    cs = Client.authenticate(params[:client_id], params[:client_secret])
    if (cs.nil?)
      render :json => {:status => "authFailure"}
    elsif (EndUserSession.authenticate(params[:email], params[:auth_token]))
      render :json => {:status => "ok", :data => {:status => "success"}}.to_json
    else
      render :json => {:status => "ok", :data => {:status => "failure"}}.to_json
    end
  end

  def fetchBasicInfo
    cs = Client.authenticate(params[:client_id], params[:client_secret])
    if (cs.nil?)
      render :inline => {:status => "authFailure"}.to_json
    else
      us = EndUser.where("email_hash = '#{params[:email]}'")
      if (us.empty?)
        render :inline => {:status => "userNotFound"}.to_json
      else
        render :inline => {:status => "ok", :data => us[0]}.to_json
      end
    end
  end
end
