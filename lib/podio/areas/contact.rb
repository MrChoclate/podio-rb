module Podio
  module Contact
    include Podio::ResponseWrapper
    extend self

    def all(options={})
      options.assert_valid_keys(:key, :value, :limit, :offset, :type, :order)

      list Podio.connection.get { |req|
        req.url("/contact/", options)
      }.body
    end

    def find(user_id)
      member Podio.connection.get("/contact/#{user_id}").body
    end

    def find_all_for_org(org_id, options={})
      options.assert_valid_keys(:key, :value, :limit, :offset, :type, :order)
      options[:type] ||= 'full'

      list Podio.connection.get { |req|
        req.url("/contact/org/#{org_id}", options)
      }.body
    end

    def find_all_for_space(space_id, options={})
      options.assert_valid_keys(:key, :value, :limit, :offset, :type, :order)
      options[:type] ||= 'full'

      list Podio.connection.get { |req|
        req.url("/contact/space/#{space_id}", options)
      }.body
    end
    
    def find_for_org(org_id)
      member Podio.connection.get("/org/#{org_id}/profile").body
    end
    
    def totals_by_org
      Podio.connection.get("/contact/totals/").body
    end

    def totals_by_org_and_space
      Podio.connection.get("/contact/totals/v2/").body
    end
    
  end
end
