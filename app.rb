require 'sinatra/base'
require './lib/game.rb'
require './lib/player.rb'

class RockPaperScissors < Sinatra::Base
  enable :sessions

  before do
    @game = Game.instance
  end

  get '/' do
    erb(:name)
  end

  post '/name' do
    player = Player.new(params[:player_name])
    Game.create(player)
    redirect '/play'
  end

  get '/play' do
    @player = @game.player
    erb(:play)
  end

  post '/calculate' do
    @game.set_player_weapon(params[:player_weapon])
    redirect '/result'
  end

  get '/result' do
    p @game.player_win?
    p 'player ' + @game.player_weapon
    p 'pc ' + @game.pc_weapon
    erb(:result)
  end

  run! if app_file == $0

end
