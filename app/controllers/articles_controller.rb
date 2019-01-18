require 'net/http'

class ArticlesController < ApplicationController

  s3 = Aws::S3::Resource.new(region:'us-east-2')

  def index
    s3 = Aws::S3::Resource.new(region: 'us-east-2')
    bucket = s3.bucket('sean-cliff-test-bucket')
    @articles = []
    bucket.objects.each do |obj|
      article = JSON.parse(obj.get.body.string)
      @articles.push(article)
    end
    render :index
  end

  def new
    @article = Article.new
  end

  def create
    s3 = Aws::S3::Resource.new(region:'us-east-2')
    obj = s3.bucket('sean-cliff-test-bucket').object(article_params[:title])
    obj.put(body: article_params.to_json)
    redirect_to "/articles/#{article_params[:title]}"
  end

  def show
    article_name = params[:id]
    s3 = Aws::S3::Resource.new(region:'us-east-2')
    obj = s3.bucket('sean-cliff-test-bucket').object(article_name).get
    @article = Article.new(JSON.parse(obj.body.string))

    render :show
  end

  def edit
    article_name = params[:id]
    s3 = Aws::S3::Resource.new(region: 'us-east-2')
    obj = s3.bucket('sean-cliff-test-bucket').object(article_name).get
    @article = Article.new(JSON.parse(obj.body.string))

    render :edit
  end

  def update
    s3 = Aws::S3::Resource.new(region:'us-east-2')
    obj = s3.bucket('sean-cliff-test-bucket').object(article_params[:title])
    obj.put(body: article_params.to_json)

    redirect_to "/articles/#{article_params[:title]}"

  end

  private

  def article_params
    params.require(:article).permit(:title, :author, :content, :short_description, :caption).merge(date: Date.today, id: SecureRandom.uuid)
  end
end
