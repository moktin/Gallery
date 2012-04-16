require 'spec_helper'

describe Category do
  it { should have_db_column(:name_fr).of_type(:string)}
  it { should have_db_column(:name_en).of_type(:string)}
  it { should have_many(:pictures).through(:category_pictures)}
  it { should belong_to(:category)}
  it { should have_many(:categories).dependent(:destroy)}

  it { should validate_presence_of(:name_fr)}
  it { should validate_presence_of(:name_en)}

  it 'validates uniqueness of name_fr' do
    Factory(:category)
    Category.new.should validate_uniqueness_of(:name_fr).scoped_to(:category_id)
  end

  it 'validates uniqueness of name_en' do
    Factory(:category)
    Category.new.should validate_uniqueness_of(:name_en).scoped_to(:category_id)
  end

  describe '.roots' do
    it 'return only the category without any parents' do
      p1 = Factory(:category)
      p2 = Factory(:category)
      p3 = Factory(:category)
      c1 = Factory(:category, :category => p1)
      c2 = Factory(:category, :category => p2)
      c3 = Factory(:category, :category => p3)
      Category.roots.should == [p1, p2, p3]
    end
  end

  describe '.children' do
    it 'return only the category with parent' do
      p1 = Factory(:category)
      p2 = Factory(:category)
      p3 = Factory(:category)
      c1 = Factory(:category, :category => p1)
      c2 = Factory(:category, :category => p2)
      c3 = Factory(:category, :category => p3)
      Category.children.should == [c1, c2, c3]
    end
  end

  describe '.childless' do
    context 'when there is kid' do
      it 'return only the category without children' do
        p1 = Factory(:category)
        p2 = Factory(:category)
        p3 = Factory(:category)
        c1 = Factory(:category, :category => p1)
        c2 = Factory(:category, :category => p2)
        Category.childless.sort.should == [c2, p3, c1].sort
      end
    end

    context 'when there is no kid' do
      it 'return only the category without child' do
        p1 = Factory(:category)
        p2 = Factory(:category)
        Category.childless.sort.should == [p1, p2].sort
      end
    end
  end

  describe '.brothers' do
    context 'root category' do
      context 'there is no other root category' do
        it 'return an empty array' do
          category = Factory(:category)
          category.brothers.should be_empty
        end
      end

      context 'there is an other root category' do
        it 'return an array with the only category' do
          category = Factory(:category)
          category1 = Factory(:category)
          category.brothers.should include(category1)
        end

        it 'has 1 brother' do
          category = Factory(:category)
          category1 = Factory(:category)
          category.should have(1).brothers
        end
      end
    end

    context 'children categories' do
      before do
        @root = Factory(:category)
        @root1 = Factory(:category)
      end

      context 'there is no other children' do
        let(:child) { Factory(:category, :category => @root)}

        it 'has no brother' do
          child.should have(0).brothers
        end
      end

      context 'there is a children of an other root' do
        before do
          Factory(:category, :category => @root1)
        end
        let(:child){  Factory(:category, :category => @root)}

        it 'has no brother' do
          child.should have(0).brothers
        end
      end

      context 'there is a children of the same root' do
        before do
          @bro = Factory(:category, :category => @root)
        end

        let(:child) { Factory(:category, :category => @root)}

        it 'has one brother' do
          child.should have(1).brothers
        end

        it 'is bro !' do
          child.brothers.should include(@bro)
        end
      end

    end
  end

  describe '.create' do
    context 'root category' do
      context 'there is no other root category' do
        it 'set the position to 1' do
          Factory(:category).position.should == 1
        end
      end

      context 'there is an other root category' do
        it 'set the position to 2' do
          Factory(:category)
          Factory(:category).position.should == 2
        end
      end

      context 'there is two other category but just one root' do
        it 'set the position to 2' do
          c = Factory(:category)
          Factory(:category, :category_id => c.id)
          Factory(:category).position.should == 2
        end
      end
    end

    context 'child category' do
      before do
        @root1 = Factory(:category)
        @root2 = Factory(:category)
      end

      context 'there is no other child category' do
        it 'set the position to 1' do
          Factory(:category, :category_id => @root1.id).position.should == 1
        end
      end

      context 'there is an other child category in an other root category' do
        it 'set the position to 1' do
          Factory(:category, :category_id => @root2.id)
          Factory(:category, :category_id => @root1.id).position.should == 1
        end
      end

      context 'there is an other child category in the same root category' do
        it 'set the position to 2' do
          Factory(:category, :category_id => @root1.id)
          Factory(:category, :category_id => @root1.id).position.should == 2
        end
      end
    end
  end

  describe '#destroy' do
    context 'root categories' do
      before do
        @root = Factory(:category)
        @root1 = Factory(:category)
        @root2 = Factory(:category)
      end

      context 'on the first record' do
        before do
          @root.destroy
          @root1.reload
          @root2.reload
        end

        it 'set position of root1 to 1' do
          @root1.position.should == 1
        end
        it 'set position of root2 to 2' do
          @root2.position.should == 2
        end
      end

      context 'on the second record' do
        before do
          @root1.destroy
          @root.reload
          @root2.reload
        end

        it 'let the position of root to 1' do
          @root.position.should == 1
        end
        it 'set position of root2 to 2' do
          @root2.position.should == 2
        end
      end

      context 'on the third record' do
        before do
          @root2.destroy
          @root.reload
          @root1.reload
        end

        it 'let the position of root to 1' do
          @root.position.should == 1
        end
        it 'let position of root1 to 2' do
          @root1.position.should == 2
        end
      end
    end

    context 'children categories' do
      before do
        @root = Factory(:category)
        @root1 = Factory(:category)
        @no_bro = Factory(:category, :category => @root1)
        @kid1 = Factory(:category, :category => @root)
        @kid2 = Factory(:category, :category => @root)
        @kid3 = Factory(:category, :category => @root)
      end

      context 'on the children of the other root parent' do
        before do
          @no_bro.destroy
          @kid1.reload
          @kid2.reload
          @kid3.reload
        end

        it 'let kid1 at position 1' do
          @kid1.position.should == 1
        end

        it 'let kid2 at position 2' do
          @kid2.position.should == 2
        end

        it 'let kid3 at position 3' do
          @kid3.position.should == 3
        end

      end

      context 'on the first record' do
        before do
          @kid1.destroy
          @kid2.reload
          @kid3.reload
        end

        it 'set position of kid2 to 1' do
          @kid2.position.should == 1
        end
        it 'set position of root3 to 2' do
          @kid3.position.should == 2
        end
      end

      context 'on the second record' do
        before do
          @kid2.destroy
          @kid1.reload
          @kid3.reload
        end

        it 'let the position of kid1 to 1' do
          @kid1.position.should == 1
        end
        it 'set position of root2 to 2' do
          @kid3.position.should == 2
        end
      end

      context 'on the third record' do
        before do
          @kid3.destroy
          @kid1.reload
          @kid2.reload
        end

        it 'let the position of kid1 to 1' do
          @kid1.position.should == 1
        end
        it 'let position of kid2 to 2' do
          @kid2.position.should == 2
        end
      end
    end
  end
end
