# General Personal Notes On The Project


## General Notes

1. When generating a controller, make sure to give it a plural name!
2. When generating a model, give it a singular name!
3. 


####
## Gems used in the project :
1. Better errors -> For better looking errors
2. Bulma-rails -> CSS styling
3. Simple_form -> Generating html forms!
4. Guard -> Handle events on file system modifications
5. Guard livereload -> Reloads the webpage when modifications are applied on the views

### Note :
* Both Guard & Guard livereload gems are needed only in the development, thus we add them to the development group in the Gemfile!

###
## Gems Configuration : 
###
### Extra Installation Step For Simple_form gem :
* After running the bundle install command, we will need to run the following command :
`rails generate simple_form:install`


* **Note** : If using the gem with bootstrap, then specify it with the generator command :   
`rails generate simple_form:install --bootstrap`

###
### Extra step for bulma gem :
1. First, rename the application.css file in the assets dir to application.scss 


2. Import bulma in the application.scss file :   
`@import "bulma"; `

###
### Guard configuration 

* Add the value <require: false> to the guard livereload gem in the Gemfile :      
`gem 'guard-livereload', '~> 2.5', '>= 2.5.2', require: false`


* Run bundle command in the terminal :     
`bundle`


* Run the command to create the Guardfile :    
`guard init livereload`


* **To execute into guard** :    
`bundle exec guard`


###
## Working With Posts
###
### Creating Posts Controller :
1. **To create the posts, we will need to generate a VMC, thus first we create the controller** :    
`rails g controller posts`


2. **Create the index.html.erb file inside of the posts directory in the views.**


3. **Specify the routes, in the routes file** :   
`resources :posts`    
&    
`root 'posts#index'`

###
### Creating A Post Model : 
1. **Generate a Post model** :    
`rails g model Post title:sting contnet:text`


* **Note** :
* We ain't need to create a column for publishing date, because rilas will already automatically include the time & date information as default with the migration!

2. **Push the migration into the database** :   
`rails db:migrate`
