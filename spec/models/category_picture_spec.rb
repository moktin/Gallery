require 'spec_helper'

describe CategoryPicture do
  it { should belong_to(:category)}
  it { should belong_to(:picture)}

  it { should have_db_column(:position)}

end
