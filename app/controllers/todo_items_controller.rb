class TodoItemsController < ApplicationController
  def index
    #we get the todo_list_id params from the routes 
    # @ inf front of a var name makes it an instance var which in Rails meand we will have access to it in our view
    @todo_list = TodoList.find(params[:todo_list_id])
    
  end
end
