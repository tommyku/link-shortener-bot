# frozen_string_literal: true
require 'telegram/bot'
require 'envyable'
require 'awesome_print'

Envyable.load(File.expand_path('env.yml', File.dirname( __FILE__)))


def handle_command(message)
  command, param = parse_command(message.text)
  case command
  when /\/start/i
    @bot.api.send_message(chat_id: message.chat.id, text: 'Your voice will be heard.')
  end
end

def parse_command(text)
  text.split(' ', 2)
end

def is_command?(message)
  message[:entities].each do |val|
    return true if val[:type] == 'bot_command'
  end
  false
end

def handle_message(message)
  # pass
end

Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_TOKEN']) do |bot|
  @bot = bot
  @bot.listen do |message|
    ap message
    if is_command?(message)
      handle_command(message)
    else
      handle_message(message)
    end
  end
end

