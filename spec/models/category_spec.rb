require 'spec_helper'

describe Category do
  it { should have_db_column(:name).of_type(:string)}
  it { should have_many(:pictures).through(:category_pictures)}
  it { should belong_to(:category)}
  it { should have_many(:categories).dependent(:destroy)}

  it { should validate_presence_of(:name)}

  it 'validates uniqueness of name' do
    Factory(:category)
    Category.new.should validate_uniqueness_of(:name).scoped_to(:category_id)
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
    it 'return only the category without children' do
      p1 = Factory(:category)
      p2 = Factory(:category)
      p3 = Factory(:category)
      c1 = Factory(:category, :category => p1)
      c2 = Factory(:category, :category => p2)
      Category.childless.should == [p3, c1, c2]
    end
  end
end
