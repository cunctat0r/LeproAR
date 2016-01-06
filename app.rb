#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:leproar.db"

class Post < ActiveRecord::Base
	validates :author, presence: true
	validates :content, presence: true
	has_many :comments
end

class Comment < ActiveRecord::Base
	validates :author, presence: true
	validates :content, presence: true	
end

get '/' do
	@posts = Post.order "created_at DESC"
	erb :index
end

before '/new' do
	@post = Post.new
end

get '/new' do
  erb :new
end

post '/new' do
  @post = Post.new params[:post]
  if @post.valid?
  	@post.save
  	redirect to '/'
  else
  	@error = @post.errors.full_messages.first
  	return erb :new
  end  
end

before '/post/:id' do
  @the_post = Post.find params[:id]
  @comments = Comment.where(post_id: params[:id])
  @comment = Comment.new
end

get '/post/:id' do  	
  erb :details
end

post '/post/:id' do
   @comment = Comment.new params[:comment]
   @comment.post_id = params[:id]
   if @comment.valid?
  	@comment.save
  	redirect to '/post/' + params[:id]
  else
  	@error = @comment.errors.full_messages.first
  	return erb :details
  end  
#   
end