#!/usr/bin/env ruby
#encoding: utf-8

require 'net/http'

def redento(rom)
  return "http://www.emuparadise.me/roms/search.php?query=#{rom.gsub(" ", "%20")}"
end

