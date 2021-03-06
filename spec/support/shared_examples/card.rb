shared_examples 'Card' do |*factory_args|
  it_behaves_like 'Likable', *factory_args
  it_behaves_like 'Figurable', *factory_args
  it_behaves_like 'Contributable', *factory_args
  it_behaves_like 'Commentable', *factory_args

  describe '#dup_document' do
    let(:card) { FactoryGirl.create(*factory_args) }

    it do
      expect(card).to be_respond_to(:dup_document)
    end

    subject(:dupped_card) { card.dup_document }

    it '自身の複製を返すこと' do
      expect(dupped_card).to be_an_instance_of(card.class)
      expect(dupped_card.id).to_not eq(card.id)
    end

    it { expect(dupped_card.title).to eq(card.title) }
    it { expect(dupped_card.description).to eq(card.description) }

    it 'figures を複製すること' do
      card.figures << FactoryGirl.build(:link_figure)
      card.figures << FactoryGirl.build(:link_figure)
      card.save!

      expect(dupped_card.figures).to_not eq(card.figures)
      expect(dupped_card.figures.size).to eq(card.figures.size)
    end

    it 'attachments を複製すること' do
      card.attachments << FactoryGirl.build(:attachment)
      card.attachments << FactoryGirl.build(:attachment)
      card.save!

      expect(dupped_card.attachments).to_not eq(card.attachments)
      expect(dupped_card.attachments.size).to eq(card.attachments.size)
    end
  end
end
