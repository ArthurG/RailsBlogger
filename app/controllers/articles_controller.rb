class ArticlesController < ApplicationController
	include ArticlesHelper

	before_filter :require_login, only: [:new, :create, :edit, :update, :destroy]
	def index
		@articles = Article.all
	end

	def show
		@article = Article.find_by(id: params[:id])
		@comment = Comment.new
		@comment.article_id = @article.id
	end

	def new 
		@article = current_user.articles.new
	end

	def create
 		@article = current_user.articles.new(article_params)
		@article.save
		flash.notice = "Article #{@article.title} was created"
		redirect_to article_path(@article)
	end

	def destroy
		article = Article.find(params[:id])
		flash.notice = "Article #{article.title} was deleted"
		article.destroy
		redirect_to articles_path
	end

	def edit
		@article = Article.find_by(id: params[:id])
	end

	def update
		@article = Article.find_by(id: params[:id])
		@article.update(article_params)
		flash.notice = "Article #{@article.title} was updated!"
		redirect_to article_path(@article)
	end
end
