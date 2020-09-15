class StatsController < ApplicationController

    def index
    end

    def new
    end

    def short_url
        response = Hash.new
        client = Bitly::API::Client.new(token: "cb454e48cd6ecf351101693af7a86df1f9575064")

        if params[:long_url].present?
            begin
                @stat = Stat.find_by_url(params[:long_url])

                if @stat.present?
                    response['short_url'] = @stat.shorten_url
                else
                    bitly = client.shorten(long_url: params[:long_url])
                    response['short_url'] = bitly.link

                    @stat = Stat.new
                    @stat.url = params[:long_url]
                    @stat.shorten_url = bitly.link
                    @stat.save
                end

                response['status'] = "ACK"
                response['message'] = "Success"
            rescue Exception => e
                response['status'] = "NACK"
                response['message'] = e.message
            end
        else
            response['status'] = "NACK"
            response['message'] = "Please enter a url"
        end

        respond_to do |format|
            format.html
            format.json { render json: response.to_json, :callback => params[:callback] }
        end
    end

    def clicks_count_update
        @stat = Stat.find_by_shorten_url(params[:short_url])
        if @stat.present?
            @click = @stat.click_lists.new
            @click.country = request.location.country
            @click.client_ip = request.ip
            @click.save
        end
        respond_to do |format|
            format.html
            format.json { render json: "Count updated successfully.".to_json, :callback => params[:callback] }
        end
    end

    def routing_404
        render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => true
    end

end
