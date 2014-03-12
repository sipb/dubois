require 'spec_helper'

describe "mailing_lists/edit" do
  before(:each) do
    @mailing_list = assign(:mailing_list, stub_model(MailingList,
      :name => "MyString"
    ))
  end

  it "renders the edit mailing_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mailing_list_path(@mailing_list), "post" do
      assert_select "input#mailing_list_name[name=?]", "mailing_list[name]"
    end
  end
end
