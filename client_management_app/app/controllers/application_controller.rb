require './config/environment'

class ApplicationController < Sinatra::Base #getting all the code from Sinatra gem into our Application Controller, then we give the applicationcontroller gem to the other controllers which will also give them sinatra via ApplicationController 

  configure do
    set :public_folder, 'public' #not sure
    set :views, 'app/views' # Not sure
    enable :sessions # enables sessions so we can track users,
    set :session_secret, "do_not_tell_anyone" #makes sessions private? secure?

  end

  get "/" do # this takes us welcome page this is part of the URL/URI
    erb :welcome # this is the view page, Saying when a user goes to the '/' page of our website it will upload this view page or like proccess the code on the view page. (need to edit the view page)
  end

  helpers do #helper method so we can see if a user is logged_in or not, Makes sense to have it hear so that we can use in both controllers instead of recreating the code in both, (useful for logging out,)
  def logged_in?
    !!session[:user_id] #double bang operator changes it to a boolean and then evaluates it, It is evaluting if the session user ID is true or false. 
  end 

  def current_user #used to make sure that the only the current user when they are logged in can see their stuff 
    User.find_by_id(session[:user_id]) #User class in the models, instance method (find_by_id)
  end 

end 




  


end

