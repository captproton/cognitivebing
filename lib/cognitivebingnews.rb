require "cognitivebing/version"
require 'json'
require 'open-uri'
require 'net/http'


class CognitiveBingNews
  attr_accessor :account_key
  
  def initialize(account_key, params = {})
    @account_key = account_key
  end
  
  def search(search_term, params)
    
    
    query_string = '?q='
    query_portion = URI.encode_www_form_component('\'' + search_term + '\'')
    paramsbuilder = "&Ocp-Apim-Subscription-Key=#{@account_key}"
    params.each do |k,v|
      paramsbuilder << "&#{k.to_s}=#{v.to_s}"
      
      
    end
    
    web_search_url = "https://api.cognitive.microsoft.com/bing/v5.0/news/search"
    
    
    full_address = web_search_url + query_string + query_portion + paramsbuilder   
    puts full_address
    
    uri = URI(full_address)
    req = Net::HTTP::Get.new(uri.request_uri)
    req.add_field("Ocp-Apim-Subscription-Key", @account_key)
    

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https'){|http|
      http.request(req)
    }

    body = JSON.parse(res.body, :symbolize_names => true)
        
    
    return body
  end
  
  
  
  def category(category_term, params = {})
      
    web_search_url = URI('https://api.cognitive.microsoft.com/bing/v5.0/news/')
      web_search_url.query = URI.encode_www_form({
          # Request parameters
          'category' => '#{category_term}'
    })
    
    
    
    uri = URI(web_search_url)
    req = Net::HTTP::Get.new(uri.request_uri)
    req.add_field("Ocp-Apim-Subscription-Key", @account_key)
    

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https'){|http|
      http.request(req)
    }

    body = JSON.parse(res.body, :symbolize_names => true)
        
    
    return body
  end
  
  
  def trending
    
    web_search_url = "https://api.cognitive.microsoft.com/bing/v5.0/news/trendingtopics"
    
    
    uri = URI(web_search_url)
    req = Net::HTTP::Get.new(uri.request_uri)
    req.add_field("Ocp-Apim-Subscription-Key", @account_key)
    

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https'){|http|
      http.request(req)
    }

    body = JSON.parse(res.body, :symbolize_names => true)
    
    return body
  end
end