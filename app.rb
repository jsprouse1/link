require 'sinatra'
require 'uri'
require 'active_record'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///molinks')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

set :public_folder, "public"

class Link < ActiveRecord::Base
  has_many :comment
end

class Comment < ActiveRecord::Base
  belongs_to :links
end

get '/createComment/:id' do
   @link_id = (params[:id])
  
  erb :createcomment
end

post '/createComment/' do
  comment = Comment.new(params[:comments])
  if comment.save
    redirect to "/"
  else
    return "failure!"
  end
end

get '/' do
  @links = Link.order("id DESC")
  erb :index
end

get '/about' do
  erb :about
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

def getComment(linkid) 
  return Comment.where(links_id: linkid)
end