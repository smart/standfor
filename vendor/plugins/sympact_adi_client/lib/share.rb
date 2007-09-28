module SympactAdiClient
  class Share < AdiserverResource
    self.site += '/adis/:adi_id'
    colection_name = "share"
  end
end