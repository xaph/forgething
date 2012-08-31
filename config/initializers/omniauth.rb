Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'srYvkhBfoB49Cty3F8zrVQ', 'h2TO7ZRpCdBBjDSVosUhgfHn57ada1TOBu9yHKGc'
  provider :facebook, '376676559068606', '174b7597a0c4b6d4658c5ca2a5f94a98'
end