require 'rails_helper'

RSpec.describe Application, type: :model do
  before(:all) do
    @application = Application.create(name: "Netflix", token: SecureRandom.hex(16))
  end

  it 'checks that an application can be created' do
    expect(@application).to be_valid
  end

  it 'checks that an application can be read' do
    expect(Application.find_by_name("Netflix")).to eq(@application)
  end

  it 'checks that an application can be updated' do
    @application.update(:name => "Amazon")
    expect(Application.find_by_name("Amazon")).to eq(@application)
  end

  it 'checks that an application can be destroyed' do
    @application.destroy
    expect(Application.count).to eq(0)
  end
end
