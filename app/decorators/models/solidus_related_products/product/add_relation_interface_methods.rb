# frozen_string_literal: true

module SolidusRelatedProducts
  module Product
    module AddRelationInterfaceMethods
      def name_for_relation
        name
      end

      def related_cache_key
        updated_at
      end

      def variant
        master
      end

      Spree::Product.prepend self
    end
  end
end
