Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'FYCfmMvSzulNB2fDAfqNbw', 'u1ici8DEAeWo4cQRdsjQrgT3MnmIndQGXvXGvvQcflM'
  provider :facebook, '376676559068606', '174b7597a0c4b6d4658c5ca2a5f94a98'
  provider :google , 'forgething.com', '3UbC7OxW2Z6bGZpStAlCTlFT'
end