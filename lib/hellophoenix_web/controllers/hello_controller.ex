defmodule HellophoenixWeb.HelloController do
	use HellophoenixWeb, :controller

	def index(conn, _params) do
		render conn, "index.html"
	end

	#Note: If the body of the action needs access to the full map of parameters 
	#bound to the params variable in addition to the bound messenger variable, 
	#we could define show/2 like this (pattern match): 
	#def show(con, %{"messenger" => messenger} = params)

	def show(conn, %{"messenger" => messenger}) do
		render conn, "show.html", messenger: messenger
	end

end