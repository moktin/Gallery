require 'spec_helper'

describe Picture do
  it { should belong_to(:news)}
  it { should have_many(:category_pictures)}
  it { should have_many(:categories).through(:category_pictures)}

  describe '.create_collection' do
    before do
      @pictures = [File.new(Rails.root + 'spec/fixtures/images/rails.png')] * 3
      @params = { :name => 'dinde'}
    end

    it 'create as many pictures as there is pictures arguments' do
      expect { Picture.create_collection(@params, @pictures)}.to change(Picture, :count).by(3)
    end

    it 'return pictures with all the same attributes' do
      Picture.create_collection(@params, @pictures).collect(&:name).uniq.length.should == 1
    end

    context 'pictures is nil' do
      it 'does not raise errors' do
        expect { Picture.create_collection(@params, nil)}.not_to raise_error
      end

      it 'does not create any pictures' do
        expect { Picture.create_collection(@params, nil)}.not_to change(Picture, :count)
      end
    end
  end

end
