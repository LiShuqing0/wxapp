class ArticlesController < ApplicationController
  before_filter :set_article, only: [:show]
	
  def index
    if params[:type] == "my"
      @article = Article.show
    elsif params[:type] == "pass"
      @article = Article.audit_pass
    elsif params[:type] == "wait"
      @article = Article.draft
    else
      @article = Article.audit_pass
    end

  	@query = @article.ransack(params[:q])
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

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit!
    end
end