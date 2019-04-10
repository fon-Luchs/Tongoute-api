module Tools::PolymorphicData
  def self.call(object=nil)
    {
      id: object.id,
      type: object.class.name
    }
  end
end
