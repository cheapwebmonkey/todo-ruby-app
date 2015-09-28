class TodoItemsController < ApplicationController
  def index
    #we get the todo_list_id params from the routes 
    # @ inf front of a var name makes it an instance var which in Rails meand we will have access to it in our view
    @todo_list = TodoList.find(params[:todo_list_id])
  end
  
  def new
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.new
  end
  
  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      flash[:success] = "Added todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "Oops. Try that again."
      render action: :new
    end
      
  end
  
  private
  def todo_item_params
    #use strong prarams to tell rails what it's allowed to do-here permit content as a key on the todo_item
    params[:todo_item].permit(:content)
  end
  
end
