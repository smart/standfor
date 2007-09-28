class DataElement  < AdiserverResource
  self.site += "/adis/:adi_id"
  belongs_to :scope, :polymorphic => true
end
