module Share
  def self.load_config!
    YAML.load(Rails.root.join("config",'share.yml').read)[Rails.env]
  rescue
    raise $! 
  end
  
  def self.config
    @loaded_config ||= OpenStruct.new(load_config!)
  end
end