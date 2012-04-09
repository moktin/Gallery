require 'spec_helper'

describe Page do
  it { should have_db_column(:name).of_type(:string)}
  it { should have_db_column(:slug).of_type(:string)}
  it { should have_db_column(:content).of_type(:text)}
  it { should have_db_column(:position).of_type(:integer)}
  it { should have_db_column(:online).of_type(:boolean)}

  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:content)}

  it 'validate uniqueness of name' do
    Factory(:page)
    Page.new.should validate_uniqueness_of(:name)
  end
  describe '.create' do
    context 'there is no other page' do
      it 'set the position to 1' do
        Factory(:page).position.should == 1
      end
    end

    context 'there is an other page' do
      it 'set the position to 2' do
        Factory(:page)
        Factory(:page).position.should == 2
      end
    end

  end

  describe '#destroy' do
    before do
      @page = Factory(:page)
      @page1 = Factory(:page)
      @page2 = Factory(:page)
    end

    context 'on the first record' do
      before do
        @page.destroy
        @page1.reload
        @page2.reload
      end

      it 'set position of page1 to 1' do
        @page.position.should == 1
      end
      it 'set position of page2 to 2' do
        @page2.position.should == 2
      end
    end

    context 'on the second record' do
      before do
        @page1.destroy
        @page.reload
        @page2.reload
      end

      it 'let the position of page to 1' do
        @page.position.should == 1
      end
      it 'set position of page2 to 2' do
        @page2.position.should == 2
      end
    end

    context 'on the third record' do
      before do
        @page2.destroy
        @page.reload
        @page1.reload
      end

      it 'let the position of page to 1' do
        @page.position.should == 1
      end
      it 'let position of page1 to 2' do
        @page1.position.should == 2
      end
    end
  end
end
