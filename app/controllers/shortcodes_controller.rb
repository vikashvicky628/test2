class ShortcodesController < ApplicationController
    protect_from_forgery with: :null_session
    http_basic_authenticate_with :name => "admin", :password => "password"

    def index
        @shortcodes = Shortcode.all.order('popularity DESC')
        render 'index'
    end

    def top100
        @shortcodes = Shortcode.all.order('popularity DESC').limit(100)
        render 'index'
    end

    def show
        @shortcode = Shortcode.find(params[:id])
        render 'show'
    end

    def goto
        @shortcode = Shortcode.find_by(short_url: params[:short_url])
        if @shortcode != nil
            @shortcode.increment!(:popularity,1)
            if @shortcode.save
                redirect_to @shortcode.original_url
            else
                render json: 'problem loading page'
            end
        else
            redirect_to '/'
        end
    end

    def new
        @shortcode = Shortcode.new
    end

    def create
        @shortcode = Shortcode.new
        @shortcode.original_url = params[:shortcode][:original_url]
        @shortcode.get_short_url
        @shortcode.popularity = 1
        if @shortcode.save
            UpdateTitleJob.perform_later @shortcode.id
            redirect_to '/'
        else
            render 'new'
        end
    end

    private def shortcode_params
        params.permit(:original_url)
    end

end
