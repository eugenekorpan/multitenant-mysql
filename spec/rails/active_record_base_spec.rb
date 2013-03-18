require 'spec_helper'

describe ActiveRecord::Base do
  subject { ActiveRecord::Base }
  it 'should respond to acts_as_tenant' do
    subject.should respond_to(:acts_as_tenant)  
  end

  it 'should redefine table name and primary key and keep original table name' do
    ActiveRecord::Base.stub_chain(:connection, :table_exists?).and_return(true)

    Multitenant::Mysql.stub(:tenant).and_return(true)

    class Book < ActiveRecord::Base
    end

    expect(Book.table_name).to eql('books_view')
    expect(Book.primary_key).to eql('id')
    expect(Book.original_table_name).to eql('books')
  end
end
