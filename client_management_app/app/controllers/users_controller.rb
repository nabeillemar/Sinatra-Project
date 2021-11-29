class UsersController < ApplicationController

    get '/signup' do 
        if logged_in? 
            redirect '/clients/' 
        else
            erb :"/signup" 
        end 
      end
      
    post '/signup' do 
        if @user = User.find_by(email: params[:email]) || @user = User.find_by(username: params[:username])
            redirect to "/signup"
        elsif 
            params[:username] == "" || params[:password] == "" || params[:name] == ""
            redirect to "/signup"
        else 
         @user = User.create(name: params[:name], username: params[:username], email: params[:email], password: params[:password])  
         session[:user_id] = @user.id 
         redirect '/clients/'
        end 
    end 

    get '/login' do 
        if logged_in? 
            redirect '/clients/'
        else 
            erb :'/login' 
        end 
    end 

    post '/login' do 
        user = User.find_by(username: params[:username]) 
        if user && user.authenticate(params[:password]) 
            session[:user_id] = user.id 
            redirect '/clients/'
        else 
            redirect '/login'

        end 
    end

    get '/logout' do 
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/login'
        end 
    end 
 




end 