require 'spec_helper'

describe "be_a_migration" do

  let(:migration_files) { ['db/migrate/20110504132601_create_posts.rb', 'db/migrate/20110520132601_create_users.rb'] }

  before do
    migration_files.each do |migration_file|
      allow(File).to receive(:exist?).with(migration_file).and_return(true)
    end
  end
  it 'should find for the migration file adding the filename timestamp for us' do
    expect(Dir).to receive(:glob).with('db/migrate/[0-9]*_*.rb').and_return(migration_files)
    expect('db/migrate/create_users.rb').to be_a_migration
  end
  it 'should find for the migration file when we know the filename timestamp' do
    expect('db/migrate/20110504132601_create_posts.rb').to be_a_migration
  end
  it 'should know when a migration does not exist' do
    expect(Dir).to receive(:glob).with('db/migrate/[0-9]*_*.rb').and_return([])
    expect('db/migrate/create_comments.rb').to_not be_a_migration
  end
end
