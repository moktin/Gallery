require 'spec_helper'

describe News do
  it { should validate_presence_of(:start_at)}

  it { should have_many(:pictures).dependent(:destroy)}

  it 'is not valid if start_at is superior as end_at' do
    @news = News.new(:start_at => DateTime.now + 1, :end_at => DateTime.now)
    @news.should_not be_valid
  end

  it 'does raise error if start_at is nill but end_at is filled' do
    expect { News.create(:end_at => DateTime.now)}.not_to raise_error
  end

  describe '#display_date' do
    pending 'need to be speced'
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

  describe '.with_translation' do
    context 'there is a title and a content' do
      before do
        I18n.locale = :fr
        @news1 = Factory(:news)
        @news2 = Factory(:news)
      end

      context 'there is no translation in english' do
        context 'with a locale set to fr' do
          before do
            I18n.locale = :fr
          end

          it 'return @news1 and @news2' do
            News.with_translation.should =~ [@news2, @news1]
          end
        end
        context 'with a locale set to en' do
          before do
            I18n.locale = :en
          end

          it 'return empty' do
            News.with_translation.should be_empty
          end
        end
      end

      context 'there is translation in english' do
        before do
          @news1.title_en = 'dinde1'
          @news2.title_en = 'dinde2'
          @news1.content_en = 'dinde1'
          @news2.content_en = 'dinde2'
          @news1.save!
          @news2.save!
        end

        context 'with a locale set to fr' do
          before do
            I18n.locale = :fr
          end

          it 'return @news1 and @news2' do
            News.with_translation.should =~ [@news2, @news1]
          end
        end

        context 'with a locale set to en' do
          before do
            I18n.locale = :en
          end

          it 'return @news1 and @news2' do
            News.with_translation.should =~ [@news2, @news1]
          end
        end
      end
    end

    context 'there is a title but no content' do
      before do
        I18n.locale = :fr
        @news1 = Factory(:news, :content => nil)
        @news2 = Factory(:news, :content => nil)
      end

      context 'there is no translation in english' do
        context 'with a locale set to fr' do
          before do
            I18n.locale = :fr
          end

          it 'return @news1 and @news2' do
            News.with_translation.should =~ [@news2, @news1]
          end
        end
        context 'with a locale set to en' do
          before do
            I18n.locale = :en
          end

          it 'return empty' do
            News.with_translation.should be_empty
          end
        end
      end

      context 'there is translation in english' do
        before do
          @news1.title_en = 'dinde1'
          @news2.title_en = 'dinde2'
          @news1.save!
          @news2.save!
        end

        context 'with a locale set to fr' do
          before do
            I18n.locale = :fr
          end

          it 'return @news1 and @news2' do
            News.with_translation.should =~ [@news2, @news1]
          end
        end

        context 'with a locale set to en' do
          before do
            I18n.locale = :en
          end

          it 'return @news1 and @news2' do
            News.with_translation.should =~ [@news2, @news1]
          end
        end
      end
    end

    context 'there is no title but a content' do
      before do
        I18n.locale = :fr
        @news1 = Factory(:news, :title => nil)
        @news2 = Factory(:news, :title => nil)
      end

      context 'there is no translation in english' do
        context 'with a locale set to fr' do
          before do
            I18n.locale = :fr
          end

          it 'return @news1 and @news2' do
            News.with_translation.should =~ [@news2, @news1]
          end
        end
        context 'with a locale set to en' do
          before do
            I18n.locale = :en
          end

          it 'return empty' do
            News.with_translation.should be_empty
          end
        end
      end

      context 'there is translation in english' do
        before do
          @news1.content_en = 'dinde1'
          @news2.content_en = 'dinde2'
          @news1.save!
          @news2.save!
        end

        context 'with a locale set to fr' do
          before do
            I18n.locale = :fr
          end

          it 'return @news1 and @news2' do
            News.with_translation.should =~ [@news2, @news1]
          end
        end

        context 'with a locale set to en' do
          before do
            I18n.locale = :en
          end

          it 'return @news1 and @news2' do
            News.with_translation.should =~ [@news2, @news1]
          end
        end
      end
    end

    context 'there is no title and no content' do
      before do
        I18n.locale = :fr
        @news1 = Factory(:news, :title => nil, :content => nil)
        @news2 = Factory(:news, :title => nil, :content => nil)
      end

      context 'with a locale set to fr' do
        before do
          I18n.locale = :fr
        end

        it 'return @news1 and @news2' do
          News.with_translation.should =~ [@news2, @news1]
        end

        context 'with a locale set to en' do
          before do
            I18n.locale = :en
          end

          it 'return empty' do
            News.with_translation.should =~ [@news2, @news1]
          end
        end
      end
    end
  end

  describe '#has_translation?' do
    context 'with a title and a content' do
      before :each do
        I18n.locale = :fr
        @news = Factory(:news)
      end
      context 'without en translation' do
        it 'has a french translation' do
          @news.has_translation?(:fr).should be_true
        end

        it 'has not an english translation' do
          @news.has_translation?(:en).should_not be_true
        end
      end

      context 'with en translation' do
        before :each do
          I18n.locale = :en
          @news.title = 'tiiitle'
          @news.content = 'content'
          @news.save
        end

        it 'has a french translation' do
          @news.has_translation?(:fr).should be_true
        end

        it 'has an english translation' do
          @news.has_translation?(:en).should be_true
        end
      end
    end

    context 'with a title but no content' do
      before :each do
        I18n.locale = :fr
        @news = Factory(:news, :content => nil)
      end
      context 'without en translation' do
        it 'has a french translation' do
          @news.has_translation?(:fr).should be_true
        end

        it 'has not an english translation' do
          @news.has_translation?(:en).should_not be_true
        end
      end

      context 'with en translation' do
        before :each do
          I18n.locale = :en
          @news.title = 'tiiitle'
          @news.save
        end

        it 'has a french translation' do
          @news.has_translation?(:fr).should be_true
        end

        it 'has an english translation' do
          @news.has_translation?(:en).should be_true
        end
      end
    end

    context 'with no title but a content' do
      before :each do
        I18n.locale = :fr
        @news = Factory(:news, :title => nil)
      end
      context 'without en translation' do
        it 'has a french translation' do
          @news.has_translation?(:fr).should be_true
        end

        it 'has not an english translation' do
          @news.has_translation?(:en).should_not be_true
        end
      end

      context 'with en translation' do
        before :each do
          I18n.locale = :en
          @news.content = 'conteeeeent'
          @news.save
        end

        it 'has a french translation' do
          @news.has_translation?(:fr).should be_true
        end

        it 'has an english translation' do
          @news.has_translation?(:en).should be_true
        end
      end
    end

    context 'with no title and no content' do
      before :each do
        I18n.locale = :fr
        @news = Factory(:news, :title => nil, :content => nil)
      end

      it 'has a french translation' do
        @news.has_translation?(:fr).should be_true
      end

      it 'has not an english translation' do
        @news.has_translation?(:en).should be_true
      end
    end
  end
end
