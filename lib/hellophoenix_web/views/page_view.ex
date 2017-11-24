defmodule HellophoenixWeb.PageView do
  use HellophoenixWeb, :view

  def handler_info(conn) do
  	"Request handled by: #{controller_module(conn)} . #{action_name(conn)}"
  end

  def connection_keys(conn) do
  	conn 
  	|> Map.from_struct()
  	|> Map.keys()
  end

  def getEnv() do
  	#env = Application.get_env(:hellophoenix, :debug_errors)
  	#IO.inspect env
  	env = System.get_env("MIX_ENV")
  	IO.inspect env
  	env
  end
end
