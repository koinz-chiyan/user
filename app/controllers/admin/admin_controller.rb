class Admin::AdminController < ApplicationController
  before_filter :authorize, :except => [:login, :create]

  def login
    #If not admin account exists then resirect to create page
    if(Admin.first==nil)
      flash[:notice] = "Create new account"
      redirect_to :action => :create
      return
    end
    
    session[:user_id] = nil
    if request.post?
      admin = Admin.authenticate(params[:email], params[:password])
      if admin
        session[:last_modified] = Time.now
        session[:admin_id] = admin.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :controller => 'client', :action => "index" })
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    #reset session info
    @admin=nil
    reset_session
    flash[:notice] = "Successfully logged out"
    redirect_to :controller => :admin, :action => :login
  end
  
  def create
    if(Admin.first!=nil)
      redirect_to :action => :login
      return
    end
    
    if request.post?
      @admin = Admin.new(:email=>params[:admin][:email], :password=>params[:admin][:password], :password_confirmation => params[:admin][:password_confirmation])
      if @admin.save
        flash[:notice] = 'Admin account was successfully created.'
        redirect_to :action => :login
      end
    end
  end
    
  protected
    def authorize      
      #Session times out after 10 minutes of inactivity
      if((session[:last_modified]!=nil) && (Time.now.to_i- session[:last_modified].to_i) > 10*60)
        @admin=nil
        reset_session
        flash[:notice] = "Session timed out"
        redirect_to( :controller => :admin, :action => :login ) and return if @admin==nil # not to get the double render error
      else
         session[:last_modified]=Time.now
      end
      
      @admin = Admin.find_by_id(session[:admin_id])
      unless @admin
        session[:original_uri] = request.request_uri
        flash[:notice] = "Please log in"
        redirect_to :controller => :admin, :action => :login
      end
    end
end
