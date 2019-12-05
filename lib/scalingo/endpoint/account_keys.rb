module Scalingo
  module Endpoint
    class AccountKeys < Collection
      def initialize(api, _, opts = {})
        super(api, 'keys', opts)
      end

      def collection_name
        'keys'
      end

      def create(name, content)
        post(nil, key: { name: name, content: content })
      end
    end
    class AccountKey < Resource
      def destroy
        delete
      end
    end
  end
end
