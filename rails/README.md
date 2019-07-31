
     ,-----.,--.                  ,--. ,---.   ,--.,------.  ,------.
    '  .--./|  | ,---. ,--.,--. ,-|  || o   \  |  ||  .-.  \ |  .---'
    |  |    |  || .-. ||  ||  |' .-. |`..'  |  |  ||  |  \  :|  `--, 
    '  '--'\|  |' '-' ''  ''  '\ `-' | .'  /   |  ||  '--'  /|  `---.
     `-----'`--' `---'  `----'  `---'  `--'    `--'`-------' `------'
    ----------------------------------------------------------------- 
	
    ## Courses

    	https://www.codecademy.com/learn/ruby
    	https://www.codecademy.com/learn/learn-rails
    	https://www.codecademy.com/learn/rails-auth
    	https://www.edx.org/xseries/agile-development-using-ruby-rails
    	

    ## Tutorials

    	http://tutorials.pluralsight.com/ruby-ruby-on-rails/building-a-crud-interface-with-react-and-ruby-on-rails
    	https://github.com/pluralsight/guides/tree/master/published/ruby-ruby-on-rails
		

	# Cloud9 Workspace for 

	    http://www.saasbook.info/

	# Workspace Setup

	    https://github.com/saasbook/courseware/wiki/Recommended-Setup:-GitHub,-Cloud9,-Heroku
	    https://github.com/saasbook/courseware/wiki/Setting-up-Cloud9
	    https://help.github.com/articles/generating-an-ssh-key/

	# Rails Documentation

	    http://api.rubyonrails.org/
	    http://guides.rubyonrails.org/command_line.html
	    http://guides.rubyonrails.org/debugging_rails_applications.html

	# Rails Resources / Books

	    http://learn-rails.com/
	    https://tutorials.railsapps.org
	    http://railsapps.github.io/installrubyonrails-mac.html
    
	# Mac Setup

	    http://railsapps.github.io/installrubyonrails-mac.html
	    http://railsapps.github.io/xcode-command-line-tools.html
	    https://rvm.io/rvm/install
    
	# AWS Command Line Client

	    http://docs.aws.amazon.com/cli/latest/userguide/installing.html 
	    http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html 
	    http://docs.aws.amazon.com/cli/latest/reference/s3api/delete-bucket-policy.html
    

	# Install AWS Client

	sudo pip install awscli
	aws help

	# Config AWS Client

	aws configure

	    AWS Access Key ID [None]: XXXXXXXXXXXX
	    AWS Secret Access Key [None]: XXXXXXXXXXXX
	    Default region name [None]: us-west-1
	    Default output format [None]: ENTER

	# RVM Help (Ruby Version Manager)

	rvm usage
	rvm -v
	rvm --default use 2.2.5

	# Install a version of Ruby

	rvm install 2.2.3
	rvm reinstall ruby-2.2.1
	rvm uninstall 2.2.3

	# List of installed Ruby versions
	# Also shows version of Ruby active

	rvm list

	# Change active version of Ruby

	rvm use 2.2.3

	# Show Ruby version in use

	ruby -v

	# GEM Help (Ruby Package Manager)

	gem -h (or just gem)
	gem -v

	# Display Gem Set in effect
	# Also shows list of Gem Sets

	rvm gemset list

	# Change Gem Set in use

	rvm gemset use global
	rvm gemset use default
	rvm gemset use rails3.2

	# List Gems in use (from active Gem Set)

	gem list

	# List Gems outdated (from active Gem Set)

	gem outdated

	# Create a Gem Set | Rails 3

	rvm install 2.1.9
	rvm use ruby-2.1.9@rails3.2 --create
	rvm gemset use rails3.2
	gem install rails --version=3.2.19

	# Create a Gem Set | Rails 4

	rvm install 2.2.5
	rvm use ruby-2.2.5@rails4.2 --create
	rvm gemset use rails4.2
	gem install rails --version=4.2.7

	# Create a Gem Set | Rails 5

	rvm install 2.3.1
	rvm use ruby-2.3.1@rails5.0 --create
	rvm gemset use rails5.0
	gem install rails --version=5.0.0

	# Setting Default Gemsets

	rvm use ruby-2.1.9@rails3.2 --default
	rvm use ruby-2.2.5@rails4.2 --default
	rvm use ruby-2.3.1@rails5.0 --default

	# Create Rails Projects (with specific versions)

	rails _3.2.19_ new helloworld-3
	rails _4.2.7_  new helloworld-4
	rails _5.0.0_  new helloworld-5

	# Create Rails Projects (with Database)
	rails _4.2.7_  new postgresql --database=postgresql

	# Create Rails Controller

	rails generate controller NAME [action action] [options]

	Example:

	    $ rails generate controller Movies
	        create  app/controllers/movies_controller.rb
	        invoke  erb
	        create    app/views/movies
	        invoke  test_unit
	        create    test/controllers/movies_controller_test.rb
	        invoke  helper
	        create    app/helpers/movies_helper.rb
	        invoke    test_unit
	        invoke  assets
	        invoke    coffee
	        create      app/assets/javascripts/movies.coffee
	        invoke    scss
	        create      app/assets/stylesheets/movies.scss
      
	    $ rails generate controller Actors
	      create  app/controllers/actors_controller.rb
	      invoke  erb
	      create    app/views/actors
	      invoke  test_unit
	      create    test/controllers/actors_controller_test.rb
	      invoke  helper
	      create    app/helpers/actors_helper.rb
	      invoke    test_unit
	      invoke  assets
	      invoke    coffee
	      create      app/assets/javascripts/actors.coffee
	      invoke    scss
	      create      app/assets/stylesheets/actors.scss            
        

	# Rails Controllers

	    app/controllers/actors_conroller.rb
    
	        class ActorsController < ApplicationController
	        	def index
	        		@actors = Actor.all
	        	end
        	
	            def show
	                @actor = Actor.find(params[:id])
	                @movies = @actor.movies
	            end
	        end

	    app/controllers/movies_conroller.rb
    
	        class MoviesController < ApplicationController
	        	def index
	        		@movies = Movie.all
	        	end
        
	            def show
	                @movie = Movie.find(params[:id])
	                @actors = @movie.actors
	            end
	        end

	# Rails Routes

	    config/routes.rb
    
	    	get '/movies' => 'movies#index'
	    	get '/movies/:id' => 'movies#show', as: :movie
	    	get '/actors' => 'actors#index'
	    	get '/actors/:id' => 'actors#show', as: :actor
        

	# Rails Views

	Actors:

	    app/views/actors/index.html.erb
    
	    <div class="main actor-index">
	          <div class="container">
	            <div class="row">
	              <% @actors.each do |actor| %>
	              <div class="actor col-xs-2">
	                <%= image_tag actor.image %>
	                <h3><%= actor.first_name + " " + actor.last_name %></h3>
	                <%= link_to "Learn more", actor_path(actor) %>
	              <%= link_to "Learn more", actor_path(actor) %>
	              </div>
	              <% end %>
	            </div>
	          </div>
	    </div>    

	    app/views/actors/show.html.erb
    
	     <div class="main actor-show">
	      <div class="container">
	        <!-- Display an actor's info here -->
	        <div class="actor">
	          <%= image_tag @actor.image %>
	          <div class="info">
	            <h3 class="actor-name"><%= @actor.first_name + " " + @actor.last_name  %></h3>
	            <p class="actor-bio"><%= @actor.bio %></p>
	          </div>
	        </div>
    
	        <h2>Movies</h2>
	        <% @movies.each do |movie| %>
	        <div class="movie">
	          <%= image_tag movie.image %>
	          <h3 class="movie-title"><%= movie.title %></h3>
	          <p class="movie-release-year"><%= movie.release_year %></p>
	          <p class="movie-plot"><%= movie.plot %></p>
	        </div>
	        <% end %>
	      </div>
	    </div>
   
    
    
    
    
    

	Movies:

	    app/views/movies/index.html.erb
    
	     <div class="hero">
	      <div class="container">
	        <h2>Interstellar</h2>
	        <p>Former NASA pilot Cooper (Matthew McConaughey) and a team of researchers 
	            travel across the galaxy to find out which of three planets could be 
	            mankind's new home.</p>
	        <a href="#">Read More</a>
	      </div>
	    </div>
    
	    <div class="main">
	      <div class="container">
	      <h2>Popular Films</h2>
	        <% @movies.each do |movie| %>
	        <div class="movie">
	          <%= image_tag movie.image %>
	          <h3><%= movie.title %></h3>
	          <p><%= movie.release_year %></p>
	          <p><%= movie.plot %></p>
	          <%= link_to "Learn more", movie_path(movie) %>
	        </div>
	        <% end %>
	      </div>
	    </div>


	    app/view/movies/show.html.erb
    
	    <div class="main movie-show">
	      <div class="container">
	        <div class="movie">
          
	          <!-- Display the movie's info here -->
	          <div class="info">
	            <%= image_tag @movie.image %>
	            <h3 class="movie-title"><%= @movie.title %></h3>
	            <p class="movie-release-year"><%= @movie.release_year %></p>
	            <p class="movie-plot"><%= @movie.plot %></p>
	          </div>
	        </div>
    
	        <h2>Cast</h2>
	        <% @actors.each do |actor| %>
	        <div class="actor">
	          <%= image_tag actor.image %>
	          <h3 class="actor-name"><%= actor.first_name %> <%= actor.last_name %></h3>
	          <p class="actor-bio"><%= actor.bio %></p>
	          <%= link_to "Filmography", actor_path(actor) %>
	        </div>
	    		<% end %>
	      </div>
	    </div>

    

	# Create Rails Model

	rails generate model NAME [field[:type][:index] field[:type][:index]] [options]

	Example:

	    $ rails generate model Movie              
	        invoke  active_record                                                      
	        create    db/migrate/20160726143540_create_movies.rb                       
	        create    app/models/movie.rb                                              
	        invoke    rspec                                                            
	        create      spec/models/movie_spec.rb       
        
	        app/models/movie.rb
        
	            has_many :parts 
	            has_many :actors, through: :parts
                                                                                
	    $ rails generate model Actor   
	        invoke  active_record                                                      
	        create    db/migrate/20160726143552_create_actors.rb                       
	        create    app/models/actor.rb                                              
	        invoke    rspec                                                            
	        create      spec/models/actor_spec.rb    
        
	        app/models/actor.rb
        
	            has_many :parts 
	            has_many :movies, through: :parts
                                                                                
	    $ rails generate model Part                                                      
	        invoke  active_record                                                      
	        create    db/migrate/20160726143618_create_parts.rb                        
	        create    app/models/part.rb                                               
	        invoke    rspec                                                            
	        create      spec/models/part_spec.rb    
        
	         app/models/part.rb
         
	            belongs_to :movie 
	            belongs_to :actor
            
	# Rake DB Commands

	rake db:migrate
	rake db:seed

	# Rake Usage

	rake -T

	# Run Rails App

	rails server
	rails server -e production 

	# Run Rails App (on Cloud9)

	rails server -p $PORT -b $IP
	https://rails-paulnguyen.c9users.io/

	# Run Ruby App (on Cloud9)

	ruby app.rb -p $PORT -o $IP

	# Rails Console

	rails console
	rails dbconsole 





