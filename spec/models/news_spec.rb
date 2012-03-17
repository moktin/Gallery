require 'spec_helper'

describe News do
  it { should validate_presence_of(:start_at)}

  it { should have_many(:pictures).dependent(:destroy)}

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
  describe '#main_picture' do
    before do
      @news = Factory(:news)
    end

    it 'return nil if there is not picture' do
      @news.main_picture.should be_nil
    end

    it 'return a picture if there is one picture' do
      picture = Factory(:picture)
      @news.pictures << picture
      @news.main_picture.should eq(picture)
    end
  end

  describe '#secondary_pictures' do
    before do
      @news = Factory(:news)
    end

    it 'return an empty array if there is not pictures' do
      @news.secondary_pictures.should be_empty
    end

    it 'return an empty array if there is just one picture' do
      picture = Factory(:picture)
      @news.pictures << picture
      @news.secondary_pictures.should be_empty
    end

    context 'there is more than one picture' do
      before do
        @picture1 = Factory(:picture)
        @picture2 = Factory(:picture)
        @news.pictures << @picture1
        @news.pictures << @picture2
      end

      it 'return an non empty array' do
        @news.secondary_pictures.should_not be_empty
      end

      it 'includes @picture2' do
        @news.secondary_pictures.should include(@picture2)
      end

      it 'does not include @picture2' do
        @news.secondary_pictures.should_not include(@picture1)
      end
    end
  end

end
