class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all.order('created_at ASC')

    render json: articles
  end

  def show
    article = Article.find_by(id: params[:id])

    if article.nil?
      render json: { status: false, message: 'article not found' }
    else
      render json: { status: true, article: article }
    end
  end

  def create
    new_article = Article.new(article_params)

    render json: { status: new_article.save, errors: new_article.errors }
  end

  def update
    article = Article.find_by(id: params[:id])

    if article.nil?
      render json: { status: false, message: 'article not found' }
    else
      render json: { status: article.update(article_params) }
    end
  end

  def destroy
    article = Article.find_by(id: params[:id])

    if article.nil?
      render json: { status: false, message: 'article not found' }
    else
      article.delete
    end

    render json: { status: true }
  end

  private

  def article_params
    params.require(:article).permit(:author, :title, :content)
  end
end
