# Require all files
Dir[File.dirname(__FILE__) + '/**/*.rb'].each do |f|
  require File.expand_path(f.gsub(/\.rb$/i, ''))
end
