require 'spec_helper'

#test the rspec
describe "Creating todo lists" do
  
  #make a method to hold all the redundant code
  def create_todo_list(options={})
    options[:title] ||= "Get This Stuff Done"
    options[:description] ||= "You really need to take care of this stuff."
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    
    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end
  
  it "redirects to the todo list index page on success" do
    create_todo_list
    expect(page).to have_content("Get This Stuff Done")
  end
  
  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)
    
    create_todo_list title: ""
 
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    expect(page).to_not have_content("You really need to take care of this stuff.")

  end
  
  it "displays an error when the todo list has a title less than 3 characters" do
    expect(TodoList.count).to eq(0)
    
    create_todo_list title: "Hi"
    
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    expect(page).to_not have_content("You really need to take care of this stuff.")

  end
  
  it "displays an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)
    
    create_todo_list title: "Amazon list", description: ""
 
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    expect(page).to_not have_content("Amazon list")

  end
  
  it "displays an error when the todo list has less than 5 characters description" do
    expect(TodoList.count).to eq(0)
    
    create_todo_list title: "Amazon list", description: "Help"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    expect(page).to_not have_content("Amazon list")

  end
  
end