class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all.order('created_at ASC')

    render json: articles
  end

  def create
    new_article = Article.new(article_params)

    if new_article.save
      render json: { status: new_article.save, message: new_article }
    else
      render json: { status: new_article.save, errors: new_article.errors }
    end
  end

  private

  def article_params
    params.require(:article).permit(:author, :title, :content)
  end
end
