require 'spec_helper'

describe "mailing_lists/new" do
  before(:each) do
    assign(:mailing_list, stub_model(MailingList,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new mailing_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mailing_lists_path, "post" do
      assert_select "input#mailing_list_name[name=?]", "mailing_list[name]"
    end
  end
end
