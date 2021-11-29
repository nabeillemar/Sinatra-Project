class ClientsController < ApplicationController #gets code from ApplicationController 

    get '/clients/' do # Suppose to show all the client info for each client of the user who created it 
       if logged_in? #checking if they are logged in, the helper method 
            @user = User.find(session[:user_id]) #assigning @user to the current user logged in, we are using the find instance method and connecting it to the session user ID
            @clients = Client.all # Assigning the @clients to all the Clients from the Client class/model , need this so we can use it in the view page
            #binding.pry
            erb :'/clients/index' #The view is a page filled all the client info of the user ##  ~~~~~NEED TO FIX THIS so that only that user can see their stuff, not everyone's~~~~~
        else 
           redirect "/login" # If they are not logged in they will be redirected to the login in page so they can log in 
    end 
end 


get '/clients/new' do 
    if logged_in? # checking if they are logged in 
        #@user = current_user #@user is current_user, ~~~~~do we need this again??~~~~~ ***Looks like we don't need it, code still works, because we already said it in this controller or because logged_in? method already check this. 
    erb :'clients/new'
    else
        redirect '/login'
    end 
end 


 post '/clients/' do 
    #@client = Client.all 
    @user = current_user # We need this because we use @user lower this this route
        #if params[:client][:name] == "" || !params[:client][:enrollment_date] == ""  #took off !params[:client][:enrollment_date],
        if params[:client][:name].empty? || params[:client][:enrollment_date].empty? ## saying if the form from clients/new has its name or its enrollment date blank it should redirect to the new page
            redirect to "/clients/new"
        else 
       # @client = Client.create(name: params[:client][:name], enrollment_date: params[:client][:enrollment_date], case_note: params[:client][:case_note])
       # @client.user = User.find_or_create_by(username: params[:username])
       # @client.save
       @user.clients.create(name: params[:client][:name], enrollment_date: params[:client][:enrollment_date], case_note: params[:client][:case_note]) #creating a new instance of a client class by using the information from the form. #note: Params uses the name idenfiier to connect, also the name: enrollment_date: are the class attriubutes from the tables we created
       # binding.pry
      # redirect("/clients/#{@client.id}")   
      redirect '/clients/' #redirects back to the user's home page which is just the list of all their clients 
    end 
end 


=begin get '/clients/:id' do #gets the user's client ID's only, should not let me look at other clients that I did not create
    if logged_in? #checked if they are logged in 
        @user = User.find(session[:user_id])
        #@user = current_user #not sure if we need this 
        @client = Client.all.find(params[:id]) #@client = all clients find by params[:id)]...... Shouldn't be find by params[:user_id]
        @user.id == @client.user_id #need something that connects both of them to verify like username created, is there like a client.user id?
      #binding.pry
    erb :'clients/show'
    else
        redirect '/login'
    end 
end 
=end

get '/clients/:id' do #gets the user's client ID's only, should not let me look at other clients that I did not create
    if logged_in? #checked if they are logged in 
        @user = User.find(session[:user_id]) #assigning the varaible @user to the current user
        #@user = current_user #not sure if we need this 
        @client = Client.all.find(params[:id]) #saying that @client equals the client.id. going through the list of Client instance and finding with the params of :id that we have in the URL/URI 
        #binding.pry
           if  @user.id == @client.user_id #making sure that only this user's client shows up. Confirming that the current user equals the client instance user ID 
            #binding.pry
                erb :'clients/show' #it will show the client's individual page 
            else
            redirect '/login' #if none of the above pass they will be redirect to the login page, if they are logged in it will take them back to their index page, for instance if they try getting in to someone else's clients 
            end 
    end 
end 


 get '/clients/:id/edit' do #to edit each client instance 
    if logged_in? #checking if they are logged in 
        @client = Client.all.find(params[:id]) #assigning the @client to the ID in the URL 
        erb :'clients/edit' #going to the edit page 
    else 
        redirect '/login'
    end 
end 


patch '/clients/:id' do # patches to the client ID 
    @client = Client.all.find(params[:id]) #looks for the correct ID 
    #binding.pry
    if params[:client][:name] == "" || !params[:client][:enrollment_date] == " " || params[:client][:case_note] == " "  #**Not working, bascially mandating all the fields, but right now seems like you can add the name and casnote and it will work
        redirect to "/clients/#{@client.id}/edit"
    else 
        @client.update(params[:client])
        redirect '/clients/#{@client.id}'
    end
end 



#delete '/clients/:id/delete' do 

delete '/clients/:id'  do #Delete route
    @client = Client.all.find(params[:id]) #finding the ID params and making it to the @client 
    @client.delete #deleting the client 
    redirect '/clients/' #redirecting you back to your homepage
  end




end     