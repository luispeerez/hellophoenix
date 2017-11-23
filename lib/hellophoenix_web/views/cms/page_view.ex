defmodule HellophoenixWeb.CMS.PageView do
  use HellophoenixWeb, :view

  alias Hellophoenix.CMS

  def author_name(%CMS.Page{author: author}) do
  	author.user.name
  end
end
