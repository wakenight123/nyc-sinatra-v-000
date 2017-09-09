class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures' do

    if !params["figure"]["name"].empty?
      @figure = Figure.create(:name =>params["figure"]["name"])
    end
    @figure.save

    if !params["title"]["name"].empty?
      @title = Title.create(:name => params["title"]["name"])
      @title.save
      @figure.title_ids = params["figure"]["title_ids"]
      @figure.title_ids = @figure.title_ids << @title.id
      #binding.pry
    else
      @figure.title_ids = params["figure"]["title_ids"]
    end

    if !params["landmark"]["name"].empty?
      @landmark = Landmark.create(:name => params["landmark"]["name"])
      @landmark.save
      @figure.landmark_ids = params["figure"]["landmark_ids"]
      @figure.landmark_ids = @figure.landmark_ids << @landmark.id
      #binding.pry
    else
      @figure.landmark_ids = params["figure"]["landmark_ids"]
    end

    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])

    if !params["figure"]["name"].empty?
      @figure.update(:name => params["figure"]["name"])
    end

    Title.all.each do |title|
      if title.name == params["title"]["name"]
        @figure.title_ids << title.id
      end
    end

    #if !params["title"]["name"].empty? && !Title.all.include?(params["title"]["name"])
    #  @title = Title.create(:name => params["title"]["name"])
    #  @title.save
    #  @figure.title_ids = params["figure"]["title_ids"]
    #  @figure.title_ids = @figure.title_ids << @title.id
      #@figure.titles = @figure.titles << @title
    #  @figure.save

    #else
    #  @figure.title_ids = params["figure"]["title_ids"]
    #end

    if !params["landmark"]["name"].empty?
      @landmark = Landmark.create(:name => params["landmark"]["name"])
      @landmark.save
      @figure.landmark_ids = params["figure"]["landmark_ids"]
      @figure.landmark_ids = @figure.landmark_ids << @landmark.id

      #@figure.landmarks = @figure.landmarks << @landmark
      @figure.save
    else
      @figure.landmark_ids = params["figure"]["landmark_ids"]
    end

    redirect to "/figures/#{@figure.id}"
  end

end
