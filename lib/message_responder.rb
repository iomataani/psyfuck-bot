require './models/user'
require './lib/message_sender'

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

    on (/^\/wiki (.+)/) do |cerca|
      answer_wiki(cerca)
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

    aiotto = """Al momento funziona solo il comando
/wiki <parole> per cercare le voci nella wikispix"""

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

  def answer_wiki(cerca)
    if cerca == nil || cerca == ""
      MessageSender.new(bot: bot, chat: message.chat, text: "Uso: /wiki <testo da cercare>").send
    else
      MessageSender.new(bot: bot, chat: message.chat, text: wikispix(cerca)).send
    end
  end

end
