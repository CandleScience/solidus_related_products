# frozen_string_literal: true

FactoryBot.define do
  factory :relation_type, class: Spree::RelationType do
    sequence(:name) { |n| "Product Relation ##{n}" }
    description { "A relationship between products and/or variants" }
    bidirectional { false }
    applies_from { "Spree::Product" }
    applies_to { "Spree::Product" }

    trait :bidirectional do
      bidirectional { true }
    end

    trait :variant_to_product do
      applies_from { "Spree::Variant" }
      applies_to { "Spree::Product" }
    end

    trait :product_to_variant do
      applies_from { "Spree::Product" }
      applies_to { "Spree::Variant" }
    end

    trait :variant_to_variant do
      applies_from { "Spree::Variant" }
      applies_to { "Spree::Variant" }
    end
  end

  factory :relation, class: Spree::Relation do
    relation_type
    association :relatable, factory: :product
    association :related_to, factory: :product
    description { "Two entities that are related to one another" }

    trait :variant_to_product do
      association :relation_type, factory: %i{relation_type variant_to_product}
      association :relatable, factory: :variant
      association :related_to, factory: :product
    end

    trait :product_to_variant do
      association :relation_type, factory: %i{relation_type product_to_variant}
      association :relatable, factory: :product
      association :related_to, factory: :variant
    end

    trait :variant_to_variant do
      association :relation_type, factory: %i{relation_type variant_to_variant}
      association :relatable, factory: :variant
      association :related_to, factory: :variant
    end
  end
end
