# General Personal Notes On The Project


## General Notes

1. When generating a controller, make sure to give it a plural name!


2. When generating a model, give it a singular name!


3. To view the routes of our webApp, we can sue either `rials routes ` or `rake routes`


4. The post_params is a private method in the posts controller, which will allow us to pass parameters we need to use in other methods like in the create one!


5. In the create method we create the new post passing the post's params, and then check the post has been saved so we direct the user to the post, else we will render a new post!   
``` ruby
def create
   @post = Post.new(post_params)
   if @post.save
    redirect_to @post
   else
    render 'new'
   end
end
```

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


3. **Create a <new.html.erb> file inside the post view, to be the view for creating a new post** 

###
#### 2. Creating The Form :

* First, we need to call the simple_form gem to help up with creating the new post form "**Must be included inside a <%= code here %>**" :
```erbruby
 simple_form_for @post do |f| 
```

###
* Then for the title field, we specify the param we want to input which is **:title** 


* **input_html** is used to tell simple_for gem which type of field we want |**input is needed here**|


* wrapper: false, is set to false so it ain't conflict with the bulma gem, because it has the same class!


* html_label: {class: 'label'}, is for setting the label for the field!
```html
<div class="field">
      <div class="control">
        <%= f.input :title, input_html: {class: 'input'}, wrapper: false, label_html: {class: 'label'}  %>
      </div>
    </div>
```

###
* We apply the same logic for the content, with changes to the param from :title to :content and the html_input: {class: 'text'}
```html
<div class="field">
      <div class="control">
        <%= f.input :content, input_html: {class: 'textarea'}, wrapper: false, label_html: {class: 'label'} %>
      </div>
    </div>
```

###
* Last, the submit button "**Must be included inside a <%= code here %>**" : 
```erbruby
f.button :submit, 'Create New Post', class: "button is-primary" 
```

