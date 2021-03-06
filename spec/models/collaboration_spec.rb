require 'spec_helper'

describe Collaboration do

  describe "#owner" do
    let(:collaboration) { FactoryGirl.create(:collaboration, owner: owner) }
    context 'User' do
      let(:owner) { FactoryGirl.create(:user) }
      it { expect(collaboration).to be_respond_to(:owner) }
      it { expect(collaboration.owner).to be_an_instance_of(User) }
      it { expect(collaboration.owner.id).to eq(owner.id) }
    end
    context 'Group' do
      let(:owner) { FactoryGirl.create(:group) }
      it { expect(collaboration).to be_respond_to(:owner) }
      it { expect(collaboration.owner).to be_an_instance_of(Group) }
      it { expect(collaboration.owner.id).to eq(owner.id) }
    end
  end

  describe "#project" do
    let(:collaboration) { FactoryGirl.create(:collaboration) }
    it { expect(collaboration).to be_respond_to(:project) }
    it { expect(collaboration.project).to be_an_instance_of(Project) }
  end

end
