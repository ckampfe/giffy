# require lib
Dir['lib/*.rb'].each { |file| require File.basename(file, ".rb") }
