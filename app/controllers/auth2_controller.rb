class Auth2Controller < ApplicationController
  #Expects client_id (required), redirect_uri (optional) and (email, password) or (facebook_snid and access token)
  def authorize
    reunder :inline => "ok"
  end
  
  #Expects client_id, client_secret, code, redirect_uri (optional)
  def access_token
  end
end
