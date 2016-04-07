#!/usr/bin/env ruby
# encoding: utf-8
#
# psyfuck bot, la mascotte spixellata

require 'telegram/bot'
require 'colorize'
require 'logger'

# Log giornaliero
logger = Logger.new("./logs/log.txt", "daily")
logger.level = Logger::DEBUG

# carica il token
TOKEN = File.open("api.txt", "r").readlines

puts TOKEN.colorize(:red)

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end
  end
end

