post "/login" do
  user = User.find_by(username: params[:username])

  if user.authenticate(params[:password])
    session[:user_id] = user.id
    return user.to_json
  else
    @error = "Invalid username/password combination."
    erb :"users/login"
  end
end


get "/logout" do
  session.clear
  redirect "/"
end



post "/signup" do
  user = User.create(params[:user])
  session[:user_id] = user.id

  if user.save
    session[:user_id] = user.id
    return user.to_json
  else
    erb :"post/index"
  end
end
