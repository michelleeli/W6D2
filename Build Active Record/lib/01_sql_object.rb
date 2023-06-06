require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
  end

  def self.finalize!
  end

  def self.table_name=(table_name)
    # ...
  end

  def self.table_name
    return self.to_s.downcase + "s"
  end

  def self.all
    table_name = self.table_name
    data = DBConnection.execute(<<-SQL)
    
   SELECT * FROM #{table_name}
  SQL
  parse_all(data)
  end

  def self.parse_all(results)
    results.map!{ |result| new(result) }
  end

  def self.find(id)
    table_name = self.table_name
    data = DBConnection.execute(<<-SQL, id)
      SELECT * FROM #{table_name} WHERE id = ? LIMIT 1
    SQL
    data.first if data

  end

  def initialize(params = {})
    params.each do |attr,value|
      attr_sym = attr.to_sym
      raise"unknown attribule '#{attr}'" unless self.class.columns.include?(attr_sym)
      send("#{attr}=", value)
    end
  end

  def attributes
    # ...
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
