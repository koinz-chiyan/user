class Admin::ClientController < Admin::AdminController
  layout 'admin'

    # GET /clients
    # GET /clients.xml
    def index
      @clients = Client.all
      respond_to do |format|
        format.html
        format.xml  { render :xml => @clients }
      end
    end

    # GET /clients/new
    # GET /clients/new.xml
    def new
      @client = Client.new

      respond_to do |format|
        format.html
        format.xml  { render :xml => @client }
      end
    end

    # GET /clients/1/edit
    def edit
      @client = Client.find(params[:id])
    end

    # POST /clients
    # POST /clients.xml
    def create
      @client = Client.new
      @client.name = params[:client][:name]
      @client.client_id = params[:client][:client_id]
      @client.client_secret = params[:client][:client_secret]
      
      respond_to do |format|
        if @client.save
          flash[:notice] = 'Client was successfully created.'
          format.html { redirect_to :action => :index }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /clients/1
    # PUT /clients/1.xml
    def update      
      @client = Client.find(params[:id])

      @client.name = params[:client][:name]
      @client.client_id = params[:client][:client_id]
      @client.client_secret = params[:client][:client_secret]
            
      respond_to do |format|
        if @client.save
          flash[:notice] = 'Client was successfully updated.'
          format.html { redirect_to(:action => :index) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @level.errors, :status => :unprocessable_entity }
        end
      end
    end


    # DELETE /clients/1
    # DELETE /clients/1.xml
    def destroy
      @client = Client.find(params[:id])

      if params[:commit] == "Yes"
        @client.destroy
      end
      if(params[:commit])
        respond_to do |format|
          format.html { redirect_to :action => :index }
          format.xml  { head :ok }
        end
      end
    end
end
