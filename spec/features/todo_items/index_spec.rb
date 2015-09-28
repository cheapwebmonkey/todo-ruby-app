require 'spec_helper'

#test the rspec
describe "Viewing todo lists" do
  let!(:todo_list) {TodoList.create(title: "Work Stuff", description: "Things to do for work")}
  it "displays no items when the Todo list is empty" do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
    click_link "List Items"
    end
    expect(page).to have_content("TodoItems#index")
  end
end