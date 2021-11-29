class UsersController < ApplicationController

    get '/signup' do 
        if logged_in? #checking if you are logged in 
            redirect '/clients/' #if you are then you will be redirected to the your homepage 
        else
            erb :"/signup" # if not you will go to the sign up page 
        end 
      end
      
    post '/signup' do #the data is being posted from the signup form 
        if @user = User.find_by(email: params[:email])
            redirect to "/signup"
        elsif 
            params[:username] == "" || params[:password] == "" || params[:name] == ""# if username, name  or the password are empty you will have to enter it again 
            redirect to "/signup"
        else 
         @user = User.create(name: params[:name], username: params[:username], email: params[:email], password: params[:password]) #creating a new instance of the user using the data on the form 
         session[:user_id] = @user.id #creating the session user_id to the @user.id 
         redirect '/clients/'
        end 
    end 

    get '/login' do 
        if logged_in? #if you are login you go directly to your homepage
            redirect '/clients/'
        else 
            erb :'/login' # if not you will go to the login page 
        end 
    end 

    post '/login' do 
        user = User.find_by(username: params[:username]) #assigning user variable to your username 
        if user && user.authenticate(params[:password]) #checking if the user and the user.password match 
            session[:user_id] = user.id #making the session[user_id ] match the user.id 
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
 
    get '/users/:slug' do  #not sure what this is for .... this is used for making the URL easier to read 
        @user = User.find_by_slug(params[:slug])
        erb :"/show"
      end 



end 