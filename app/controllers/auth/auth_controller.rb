class Auth::AuthController < ApplicationController
  def authenticate
    cs = Client.authenticate(params[:client_id], params[:client_secret])
    if (cs) 
      render :inline => {:status => "ok", :data => {:status => "success", :auth_token => cs.auth_token}}.to_json
    else
      render :inline => {:status => "ok", :data => {:status => "failure"}}.to_json
    end
  end
  
  def peerAuthenticate
    if (ClientSession.authenticate(params[:client_id], params[:auth_token]))
      render :inline => {:status => "ok", :data => {:status => "success"}}.to_json
    else
      render :inline => {:status => "ok", :data => {:status => "failure"}}.to_json
    end
  end
end
