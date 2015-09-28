require 'spec_helper'

#test the rspec
describe "Viewing todo lists" do
  let!(:todo_list) {TodoList.create(title: "Work Stuff", description: "Things to do for work")}
  
  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end
  
  it "is successful with valid content" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "Add Bobby Lee to Crackers"
    click_button "Save"
    expect(page).to have_content("Added todo list item.")
    #add to ul
    within("ul.todo_items") do
      expect(page).to have_content("Add Bobby Lee to Crackers")
    end
  end
  
end