require 'sinatra'
require 'uri'
require 'active_record'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///mylinks')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class Link < ActiveRecord::Base
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :link
end

get '/comment/:link' do

  @comment = Comment.find_by(link_id:params[:link])
  erb :comment
end

post '/comment/:link' do
  comment = Comment.new(params[:link])
  if comment.save
    redirect to "/"
  else
    return "failure!"
  end
end

get '/' do
  @links = Link.order("id DESC")
  @comment = Comment.order("id DESC")
  erb :index
end

get '/create' do
  erb :create
end

post '/create' do
  link = Link.new(params[:link])
  if link.save
    redirect to "/"
  else
    return "failure!"
  end
end
