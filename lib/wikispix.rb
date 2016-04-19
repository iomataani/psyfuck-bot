#!/usr/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'json'

WIKISPIX = URI("http://www.spixellati.it/wiki/api.php")

def wikispix(voce)
  parametri = {action: "query", list: "search", srsearch: voce, format: "json"}
  WIKISPIX.query = URI.encode_www_form(parametri)

  risposta = Net::HTTP.get_response(WIKISPIX)

  # puts risposta.body if risposta.is_a?(Net::HTTPSuccess)
  
  if risposta.is_a?(Net::HTTPSuccess)
  # ora parsiamo il JSON e tiriamo fuori il titolo da rispondere
  begin
  titolo = JSON.parse(risposta.body)["query"]["search"][0]["title"]
  rescue
  end
  if titolo == nil
    link = "Non ho trovato un cazzo!!"
  else
    link = "http://www.spixellati.it/wiki/index.php?title=" + titolo.gsub(" ", "_")
  end
  else
    link = "Ci sono GROSSI problemi nel bot, fottetevi, qualcuno sistemerà"
  end
  
  return link
end
