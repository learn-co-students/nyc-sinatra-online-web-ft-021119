class FiguresController < ApplicationController
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/create_figure'
  end

  post '/figures' do

    @figure = Figure.create(name: params[:figure][:name]) if !params[:figure][:name].empty?

    @figure.title_ids = params[:figure][:title_ids]
    if !params[:title][:name].empty?
      @new_title = Title.create(name: params[:title][:name])
      @figure.titles << @new_title
      @figure.save
    end

    @figure.landmark_ids = params[:figure][:landmark_ids]
    if !params[:landmark][:name].empty?
      @new_landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
      @figure.landmarks << @new_landmark
      @figure.save
    end

    @figure.save
    redirect '/figures'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/figures'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure[:name] = params[:figure][:name] if !params[:figure][:name].empty?

    if !params[:landmark][:name].empty?
      @new_landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
      @figure.landmarks << @new_landmark
      @figure.save
    end

    @figure.save
    redirect "/figures/#{params[:id]}"
  end

end
