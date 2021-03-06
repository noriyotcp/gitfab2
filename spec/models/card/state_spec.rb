require "spec_helper"

describe Card::State do
  it_behaves_like 'Annotable', :state
  it_behaves_like 'Card', :state
  it_behaves_like 'Orderable', :state
  it_behaves_like 'Orderable Scoped incrementation', [:state], :recipe

  describe '.ordered_by_position' do

    let(:state){FactoryGirl.build :state}
    it { expect(Card::State).to be_respond_to(:ordered_by_position) }
  end

  describe "#is_taggable?" do

    let(:state){FactoryGirl.build :state}
    subject{state.is_taggable?}
    it{should be false}
  end

  describe '#to_annotation!(parent_state)' do
    let!(:state){ FactoryGirl.create(:state) }
    let!(:parent_state){ FactoryGirl.create(:state) }
    describe '内容を維持してAnnotationとして作りなおす' do
      subject!(:new_annotation) { state.to_annotation!(parent_state) }
      it { expect(new_annotation).to be_an_instance_of(Card::Annotation) }
      it { expect(new_annotation.title).to eq(state.title) }
      it { expect(state).to be_destroyed }
    end
    it 'parent_stateのannotationsに追加する' do
      expect {
        state.to_annotation!(parent_state)
      }.to change { parent_state.annotations(true).count }
    end
  end
end
