module StatsHelper

    def stat_country_list(stat)
        country_list = []
        
        if stat.present?
            stat.click_lists.each do |click|
                country_list << click.country
            end
        end

        return country_list.uniq.join(",")
    end

end
