module ApplicationHelper
  def offsite?
    not PGHCONNECTS['resolutions'].value? resolve_ip_to_abbr
  end

  def resolve_ip_to_abbr
    client_ip = request.remote_ip
    regex = /^(\d*\.\d*)/
    match = regex.match(client_ip)[1]

    if match and PGHCONNECTS["resolutions"][match.to_f]
      PGHCONNECTS["resolutions"][match.to_f]
    else
      client_ip
    end
	end

end
