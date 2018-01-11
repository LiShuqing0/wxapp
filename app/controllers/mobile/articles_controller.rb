class Mobile::ArticlesController < Mobile::BaseController
	
  def index
  	@query = Article.ransack(params[:q])
    @articles = @query.result.page(params[:page])
    respond_to do |format|
    	format.html
    	format.json {render json: {errcode: true, errmsg: 'ok', data: @articles }}
    end
  end 
end