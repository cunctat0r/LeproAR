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

get '/new' do
  erb :new
end

post '/new' do
  new_post = Post.new params[:post]
  if new_post.valid?
  	new_post.save
  	redirect to '/'
  else
  	@error = new_post.errors.full_messages.first
  	return erb :new
  end  
end