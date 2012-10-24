class Secret
  class <<self
    def encode(secret, options)
      raise 'No password given' unless options.has_key?(:with)
      `echo '#{secret}' | openssl enc -aes-256-cbc -pass pass:'#{options[:with].shellescape}' -e -base64`.strip
    end
    
    def decode(secret, options)
      raise 'No password given' unless options.has_key?(:with)
      `echo '#{secret}' | openssl enc -aes-256-cbc -pass pass:'#{options[:with].shellescape}' -d -base64`.strip
    end
  end
end
