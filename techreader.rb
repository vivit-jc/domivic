class TechReader
attr_reader :techarray

  def initialize
    @techarray = []
  end

  def initdata(&block)
    @techarray.push Tech.new(block)
  end

end