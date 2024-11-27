provider = Provider.find_or_create_by(name: "Replicate")
base_model = BaseModel.find_or_create_by(name: "Flux.1-dev", company: "Black Forest Labs")
fine_tune = FineTune.find_or_create_by(name: "Multi-Lora", base_model_id: base_model.id)

base_model.provider_links.find_or_create_by(
  provider: provider,
  view_link: "https://replicate.com/black-forest-labs/flux-dev",
  source_link: "black-forest-labs/flux-dev"
)

fine_tune.provider_links.find_or_create_by(
  provider: provider,
  view_link: "https://replicate.com/lucataco/flux-dev-lora",
  source_link: "lucataco/flux-dev-lora:091495765fa5ef2725a175a57b276ec30dc9d39c22d30410f2ede68a3eab66b3"
)