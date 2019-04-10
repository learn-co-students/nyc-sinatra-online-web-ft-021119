class LandmarksController < ApplicationController
  get '/landmarks/new' do
    erb :'/landmarks/create_landmark'
  end

  post '/landmarks' do
    Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])

    redirect '/landmarks'
  end

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    @landmark.name = params[:landmark][:name] if !params[:landmark][:name].empty?
    @landmark.year_completed = params[:landmark][:year_completed] if !params[:landmark][:year_completed].empty?
    @landmark.save

    redirect "/landmarks/#{params[:id]}"
  end

end
