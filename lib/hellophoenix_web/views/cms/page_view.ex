defmodule HellophoenixWeb.CMS.PageView do
  use HellophoenixWeb, :view

  alias Hellophoenix.CMS

  def author_name(%CMS.Page{author: author}) do
  	author.user.name
  end

  def structureKeys(_structure) do
  	_structure 
  	|> Map.from_struct()
  	|> Map.keys()
  end

end
