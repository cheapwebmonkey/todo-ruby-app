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
  
  
  it "displays the title of the todo list" do
    visit_todo_list(todo_list)
    within("h1") do
      expect(page).to have_content(todo_list.title)
    end
  end
  
  it "displays no items when the todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all("ul.todo_items li").size).to eq(0)
  end
  
  it "displays item content when a todo list has items" do
    #create todo list itmes first then look for them on the page
    todo_list.todo_items.create(content: "Add Bobby Lee to Crackers")
    todo_list.todo_items.create(content: "Send press releases")
    todo_list.todo_items.create(content: "Add SMS numbers to marketing list")
    
    visit_todo_list(todo_list)
    expect(page.all("ul.todo_items li").size).to eq(3)
   
    within "ul.todo_items" do
      expect(page).to have_content("Add Bobby Lee to Crackers")
      expect(page).to have_content("Send press releases")
      expect(page).to have_content("Add SMS numbers to marketing list")
    end
  end
end