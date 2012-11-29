module ApplicationHelper

    ## Regulary Expression constant for IP addresses
    IP_REGEX = /\A(\d*\.\d*)/

    def offsite?
        Site.all.each do |site|
          return false if site[:name] == ip_to_name
        end

        true
    end

    def ip_to_name
        client_ip = request.remote_ip
        match = IP_REGEX.match(client_ip)[1]

        site_abbr = nil

        Site.all.each do |site|
          site_abbr = site[:abbr] if site[:base_ip] == match.to_s
        end

        return site_abbr
    end

end
