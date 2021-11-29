class ClientsController < ApplicationController 

    get '/clients/' do 
       if logged_in? 
            @user = User.find(session[:user_id]) 
            @clients = Client.all 
            erb :'/clients/index' 
        else 
           redirect "/login" 
    end 
end 


get '/clients/new' do 
    if logged_in? 
        erb :'clients/new'
    else
        redirect '/login'
    end 
end 


 post '/clients/' do 
    @user = current_user 
        if params[:client][:name].empty? || params[:client][:enrollment_date].empty? 
            redirect to "/clients/new"
        else 
       @user.clients.create(name: params[:client][:name], enrollment_date: params[:client][:enrollment_date], case_note: params[:client][:case_note]) 
      redirect '/clients/' 
    end 
end 


get '/clients/:id' do 
    if logged_in? 
        @user = current_user 
        @client = Client.all.find(params[:id]) 
           if  @user.id == @client.user_id  
                erb :'clients/show' 
            else
            redirect '/login'  
            end 
    end 
end 


 get '/clients/:id/edit' do 
    if logged_in? 
        @client = Client.all.find(params[:id]) 
        erb :'clients/edit' 
    else 
        redirect '/login'
    end 
end 


patch '/clients/:id' do 
    @client = Client.all.find(params[:id]) 
    if params[:client][:name] == "" || params[:client][:enrollment_date] == "" || params[:client][:case_note] == " " 
        redirect to "/clients/#{@client.id}/edit"
    else 
        @client.update(params[:client])
        erb :'clients/show'
    end
end 



delete '/clients/:id'  do 
    @client = Client.all.find(params[:id]) 
    @client.delete 
    redirect '/clients/' 
  end




end     