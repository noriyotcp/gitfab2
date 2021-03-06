require "spec_helper"

describe Card::Annotation do
  it_behaves_like 'Card', :annotation
  it_behaves_like 'Orderable', :annotation
  it_behaves_like 'Orderable Scoped incrementation', [:annotation], :annotatable

  describe '.ordered_by_position' do
    let(:annotation){ FactoryGirl.create(:annotation) }
    it { expect(Card::Annotation).to be_respond_to(:ordered_by_position) }
  end

  describe "#is_taggable?" do
    let(:annotation){ FactoryGirl.create(:annotation) }
    subject{annotation.is_taggable?}
    it{should be false}
  end

  describe '#to_state!(recipe)' do
    let!(:annotation){ FactoryGirl.create(:annotation) }
    let!(:recipe){ FactoryGirl.create(:recipe) }
    describe '内容を維持してStateとして作りなおす' do
      subject!(:new_state) { annotation.to_state!(recipe) }
      it { expect(new_state).to be_an_instance_of(Card::State) }
      it { expect(new_state.title).to eq(annotation.title) }
      it { expect(annotation).to be_destroyed }
    end
    it 'recipeのstatesに追加する' do
      expect {
        annotation.to_state!(recipe)
      }.to change { recipe.states(true).count }
    end
  end
end
