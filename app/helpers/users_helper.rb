module UsersHelper
  def offsite?
    PGHCONNECTS['resolutions'].value?(@user.registered_at)
  end
end
