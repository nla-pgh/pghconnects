module ApplicationHelper

    ## Regulary Expression constant for IP addresses
    IP_REGEX = /\A(\d*\.\d*)/

    ## TODO Create session controller/model and move logic to there
    def admin?
        false
    end

    def offsite?
        Site.all.each do |site|
          return false if site[:name] == ip_to_name
        end

        true
    end

    # TODO Move any site related logic to site model/controller
    def ip_to_name
        client_ip = request.remote_ip
        match = IP_REGEX.match(client_ip)[1]

        Site.all.each do |site|
            return site[:name] if site[:base_ip] == match.to_s
        end

        match
    end

end
