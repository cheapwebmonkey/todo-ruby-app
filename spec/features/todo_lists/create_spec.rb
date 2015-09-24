require 'spec_helper'

#test the rspec
describe "Creating todo lists" do
  it "redirects to the todo list index page on success" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    
    fill_in "Title", with: "Get This Stuff Done"
    fill_in "Description", with: "You really need to take care of this stuff."
    click_button "Create Todo list"
    
    expect(page).to have_content("Get This Stuff Done")
  end
  
  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    
    fill_in "Title", with: ""
    fill_in "Description", with: "You really need to take care of this stuff."
    click_button "Create Todo list"
 
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    expect(page).to_not have_content("You really need to take care of this stuff.")

  end
  
  it "displays an error when the todo list has a title less than 3 characters" do
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    
    fill_in "Title", with: "Hi"
    fill_in "Description", with: "You really need to take care of this stuff."
    click_button "Create Todo list"
 
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    expect(page).to_not have_content("You really need to take care of this stuff.")

  end
  
end