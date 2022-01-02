class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "secrets", password: "shouldnotbehere",
  except: [:index, :show]

  #Read 
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  #Create
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
    render :new, status: :unprocessable_entity  
    end
  end

  #Update
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  #Delete
  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    redirect_to root_path
  end

  private
  def article_params
      params.require(:article).permit(:title, :body, :status)
  end

end
