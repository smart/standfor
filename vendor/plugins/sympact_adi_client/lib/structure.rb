class Structure < AdiserverResource

  def example
    @adi = self.get(:example, :id => self.id )
  end
end
