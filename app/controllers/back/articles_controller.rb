class Back::ArticlesController < Back::BaseController
  before_filter :set_article, only: [:show,:destroy]
	
  def index
  	@query = Article.ransack(params[:q])
    @articles = @query.result.page(params[:page]).per(10)
    respond_to :html, :json
  end

  def new
  	@article = Article.new
  end

  def create
  	@article = Article.new(article_params)
  	if @article.save
  	  redirect_to articles_path
  	else
  	  render :edit
  	end
  end

  def show
    respond_to :html, :json
  end

  def destroy
    @article.destroy
    redirect_to :back
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit!
    end
end