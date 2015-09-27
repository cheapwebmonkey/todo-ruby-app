require 'spec_helper'

#test the rspec
describe "Deleting todo lists" do
  let!(:todo_list){TodoList.create(title: "Work Stuff", description: "Stuff I need to do for work.")}
  
  it "is successful when clicking the destroy link" do
    visit "/todo_lists"
    #click on destroy link inside table row
    within "#todo_list_#{todo_list.id}" do
      click_link "Destroy"
    end
    #once we click the destroy link we will expect the page to display
    expect(page).to_not have_content(todo_list.title)
    expect(TodoList.count).to eq(0)
  end
end