require 'spec_helper'

describe News do
  it { should validate_presence_of(:start_at)}

  it { should have_many(:pictures)}

  it 'is not valid if start_at is superior as end_at' do
    @news = News.new(:start_at => DateTime.now + 1, :end_at => DateTime.now)
    @news.should_not be_valid
  end

  describe '#display_date' do
    context 'only the start_at is set' do
      before do
        @news = Factory(:news, :start_at => DateTime.now)
      end

      it 'match The' do
        @news.display_date.should =~ /The/
      end
      it 'does not match to' do
        @news.display_date.should_not =~ /to/
      end
    end

    context 'both date are set' do
      before do
        @news = Factory(:news, :start_at => DateTime.now, :end_at => DateTime.now + 3.days)
      end

      it 'match to' do
        @news.display_date.should =~ /to/
      end

      it 'match from' do
        @news.display_date.should =~ /From/
      end
    end

  end
end
