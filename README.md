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


4. **Insert title and content validation inside of the Post model** :
```erbruby
  validates :title, presence: true
  validates :content, presence: true
```

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
###

#### 3. Show the post :
* To display the post, we will need to define a show function inside of the post controller to find the post by its id :
```erbruby
@post = Post.find(params[:id])
```


* Create a show page inside the posts view.


* Create the form of displaying the post data :

```html
<section class="section">
    <container class="container">
      <h1 class="title"><%= @post.title %></h1>
      <div class="content">
        <%= @post.content %>
      </div>
    </container>
  </section>
```
###
#### 4. Display the posts on the index page :

1. **First, we will need to define the index function inside of the post controller  :**   


**Note :** 
   * The tag is in plural @posts and not @post, because we ant to display all of the posts!
   * The order, is to display the posts based on the date of creation, in an DESC order.


```erbruby
@posts = Post.all.order("created_at DESC")
```

###
2. **Secondly, we will create the index page's form :**

* We define a for loop for all of the posts included :

```erbruby
 @posts.each do |post| 
```
###
* Inside of it, we create the card in which each of the posts will be displayed : 

```html
<div class="card">
          <div class="card-content">

            <div class="media">
              <div class="media-content">
                <p class="title is-4"><%= link_to post.title, post %></p>
              </div>
            </div>

            <div class="content">
              <%= post.content %>
            </div>

            <div class="comment-count">
              <span class="tag is-rounded"><%# comment count %></span>
            </div>

          </div>
        </div>
```

###
* Limiting the number of words to be displayed with the post on the index page :  
  * We use the truncate and then specify the amount of words to be displayed!
```html
<div class="content-teaser"><%= truncate post.content, length: 150 %></div>
```
###
#### 5. Making Application Layout :

* Inside of the section, we added a hero-body, so it shows the name of the page the user is at, at the top

```html
<div class="hero-body">
      <div class="container has-text-centered">
        <h1 class="title">
          <%= yield  :page_title%>
        </h1>
      </div>
    </div>
```

* Then we added the tag on each of the view pages for posts, so it renders them : 
###
1. On the index page to render "Welcome To PostPick" :
```html
<content_for :page_title, "Welcome To PostPick">
```

2. On the show page, to render the title of the article :
```erbruby
<content_for :page_title, @post.title>
```

3. On the newPost page, to render "Create new post" :
```html
<content_for :page_title, "Create New Post">
```
###
* **NOTE :** We will have the add the content_for block on each of the posts view pages, so it ain't stumble on any errors!

###
## Updating Posts:

* To update a post, we will need to define two functions in the post controller, an edit function and an update function!

###
### 1.  Edit Function :

The edit function will be rendered by the update def in a specific case :
```erbruby
def edit
    @post = Post.find(params[:id])
end
```
###
### 2. Update Function :

* The core def for updating the post, it will first look for the post, and then pass the new post_params to the post and check if it's updated, so it redirect the user to the updated post, else, it will rendner the def edit which will again find the post by its id :

```erbruby
def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
end
```
###
### 3. Adding the update button to the show page of the posts' view :

* Here, we added the actions navbar at the top of the article's content, note that in the edit button, we passed the @post variable in the edit_post_path :
```erbruby
<%link_to "Edit", edit_post_path(@post), class: "button"%>
```


###
### 4. Creating the update html.erb page in the posts views.
*Same html used here as in the new html.erb page!


###
## Deleting Posts:

1. To delete a post, we will need a destroy function in the post controller : 
```erbruby
def destroy 
  @post = Post.find(params[:id])
  
  if @post.destroy
    redirect_to root_path
  else
    render 'destroy', flash.now[:notice] = "Couldn't delete the post!"
  end
end
```

###
2. In the show.html.erb page, to give the delete button a functionality, we will assign it with the method delete, and make the path, the actual post's path handing it the variable @post! 

```erbruby
<% button_to 'Delete',post_path(@post), method: :delete, data: {confirm: "Are You Sure You Want To Delete The Article?"}, class:"button is-danger" %>
```

###
## Adding Comments :

1. Create a comment model :    
`rails g model comment name:string comment:text`


2. Pushing the model to the database .


3. Create and push a migration to add a user_id for the comments :   
`rails g migration add_user_id_to_comments`

 * Modify the def in the migration to add_column of a user_id to the comments database.
###

4. In the comments controller, we need to define a create and a destroy methods :

```erbruby
def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      redirect_to @post
    else
      flash.now[:notice] = "Couldn't add a comment!"
    end

  end
```

```erbruby
def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_to @post
      flash.now[:notice] = "Comment has been deleted!"
    else
      flash.now[:notice] = "Couldn't delete the comment!"
    end
  end
```
###
5. Add the Active Record Associations to both the comment and the post models.
 
###
6. Add the resources of the comments to the routes.rb inside of the resources :posts :
```erbruby
resources :posts do
    resources :comments
  end
```

###
7. Create a from for creating a comment <_form.html.erb> :

* We utilize the simple_form gem, here we telling it that for the @post, build a comment associated with it!
```erbruby
<% simple_form_for([@post, @post.comments.build]) do |f| %>
```

###
8. Create a view, to show the model <_comment.html.erb> make sure the the name is singular :
Inside of it, for the delete button -> 
```erbruby
<% button_to 'Delete', [comment.post, comment], method: :delete, class:"button is-danger" %>
```

###
9. Add the comments section to the show.html.erb file in the posts view : 

```html
<div class="container">
    <!-- NUMBER OF COMMENTS-->
    <h2 class="subtitle is-5"><strong><%= @post.comments.count %></strong> Comments</h2>
    <!-- THIS WILL RENDER THE COMMENTS -->
    <%= render @post.comments %>

    <!-- A FORM FOR THE USER TO LEAVE A COMMENT -->
    <div class="comment-form">
      <hr />
      <center><h3 class="subtitle is-3">Leave A Reply</h3></center>
      <%= render 'comments/form' %>
    </div>
  </div>
```

