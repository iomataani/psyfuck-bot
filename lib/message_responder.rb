require './models/user'
require './lib/message_sender'

# funzioni del bot
require './lib/wikispix'
require './lib/redento'

class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @user = User.find_or_create_by(uid: message.from.id)
  end

  def respond
    on (/^\/start/) do
      answer_with_greeting_message
    end

    on (/^\/stop/) do
      answer_with_farewell_message
    end

    on (/^\/wiki (.+)/) do |wiki|
      answer_wiki(wiki)
    end
    
    on (/^\/redento (.+)/) do |redento|
        answer_redento(redento)
    end

    on (/^\/warezzone (.+)/) do |warez|
      answer_warezzone(warez)
    end


    on (/^\/help/) do
      answer_aiotto
    end

  end

  private

  def on regex, &block
    regex =~ message.text

    if $~
      case block.arity
      when 0
        yield
      when 1
        yield $1
      when 2
        yield $1, $2
      end
    end

  end

  def answer_aiotto

    aiotto = """Uso del bot:
/wiki <parole> per cercare le voci nella wikispix
/redento <parole> per cercare i link rapidshare [semicit.]
/warezzone <parole> per dimostrare di essere il warezzone che sei!

- o - o - o - o -
Volete ampliare il bot?
Guardate qui: https://github.com/iomataani/psyfuck-bot"""

    MessageSender.new(bot: bot, chat: message.chat, text: aiotto).send
  end

  def answer_with_greeting_message
    text = "Psyfuck!"

    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  def answer_with_farewell_message
    text = "Adiòs!"

    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  def answer_wiki(wiki)
    if wiki == nil || wiki == ""
      MessageSender.new(bot: bot, chat: message.chat, text: "Uso: /wiki <testo da cercare>").send
    else
      MessageSender.new(bot: bot, chat: message.chat, text: wikispix(wiki)).send
    end
  end

  def answer_redento(redento)
    if redento == nil || redento == ""
      MessageSender.new(bot: bot, chat: message.chat, text: "Uso: /redento <testo da cercare>").send
    else
      MessageSender.new(bot: bot, chat: message.chat, text: redento(redento)).send
    end
  end

  def answer_warezzone(warez)
    if warez == nil || warez == ""
      MessageSender.new(bot: bot, chat: message.chat, text: "Uso: /warezzone <testo da cercare>").send
    else
      MessageSender.new(bot: bot, chat: message.chat, text: warezzone(warez)).send
    end
  end

end
