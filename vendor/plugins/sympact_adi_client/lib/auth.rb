class Auth < AdiserverResource
  self.site += "/adis/:adi_id"
  belongs_to :adi
end