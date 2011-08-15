class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  skip_before_filter :authorize,  :only => [:new,:create]
  def index
    @users = User.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.usertype=2
    respond_to do |format|
      if @user.save
	    session[:user_id] = @user.id
        session[:user_type]=2 
        session[:user_name]=@user.name
        format.html { redirect_to(users_url, :notice => "User #{@user.name} was successfully created.") }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_url, :notice => "User #{@user.name} was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
	begin
      @user.destroy
      flash[:notice] = "User #{@user.name} deleted"
	
	rescue Exception => e
	  flash[:notice] = e.message
	end
	
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
   def pro_regist
     @user=User.new(params[:user])
     @user.active_code = rand(Time.now.to_i).to_s
	 @user.is_activated = false
	 if @customer.save then
	    flash[:notice] = 'you have successful registered'
		flash[:name] = @customer.name
	    Sysemail.deliver_sent(@user)
		render 'sysemail/sent'
	 else 
	    flash[:notice] = 'register failed,please fill again??'
		render :action => 'account/reg'
	 end
	 end
  def pro_login
     user=User.find_by_name_and_pass(params[:user][:name],params[:user][:pass])
	 @user=user
	 if user==nil  then
	    flash[:notice] = '<h3> your name or password is not match </h3>'
		redirect_to :action => 'login'
     elsif user !=nil && user.is_activated == false
	    flash[:notice] = 'your account is not actived'
		redirect_to :action => 'login'#,  :layout => true
	 else
	    redirect_to :action => "success", :username=>customer.name
	 end
	 end
  
    def pro_activate
     user=User.find_by_name(params[:name])
	 @user=user
	 k=user.active_code.to_s
	 if user.is_activated==false then
	    user.update_attribute(:is_activated, true)

		flash[:notice] = "congratulation, you have active your account!"
		 redirect_to :action => 'activate'

	 else
	    flash[:notice] = "active failed"
		redirect_to :action => 'success'
	 end
	 
	 end
end
