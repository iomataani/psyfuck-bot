#!/usr/bin/env ruby
#encoding: utf-8

def redento(rom)
  "http://www.emuparadise.me/roms/search.php?query=#{rom.gsub(" ", "%20")}"
end

def warezzone(torrent)
  "https://torrentz.eu/search?f=#{torrent.gsub(" ", "%20")}"
end
