# frozen_string_literal: true
require 'telegram/bot'
require 'envyable'
require 'firebase'
require 'uri'

Envyable.load(File.expand_path('env.yml', File.dirname( __FILE__)))
@vowel = ['a', 'e', 'i', 'o', 'u']
@consonant = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z']

def get_short_key
  (1..4).reduce('') { |memo| memo + @consonant.sample + @vowel.sample }
end

def get_short_url(short_key)
  "http://#{ENV['SHORTENER_HOST']}/#{short_key}"
end

def get_url(text)
  URI.extract(text, ['http', 'https'])[0] || ''
end

def handle_command(message)
  command, param = parse_command(message.text)
  case command
  when /\/start/i
    @bot.api.send_message(chat_id: message.chat.id, text: 'Hey, if you send me a link I can send you a shortened version of it!')
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
  # http://stackoverflow.com/questions/1805761/check-if-url-is-valid-ruby
  unless (long_url = get_url(message.text)).empty?
      base_uri = ENV['FIREBASE_BASE_URI']
      secret_key = ENV['FIREBASE_SECRET_KEY']
      firebase = Firebase::Client.new(base_uri, secret_key)
      short_key = ''
      loop do
        short_key = get_short_key
        response = firebase.get(short_key)
        break if response.body.nil?
      end
      response = firebase.push(short_key, long_url)
      if response.success?
        @bot.api.send_message(chat_id: message.chat.id, text: "#{['alright', 'cool', 'wow', 'ok', 'fine', 'there'].sample}, try #{get_short_url(short_key)}")
      else
        @bot.api.send_message(chat_id: message.chat.id, text: 'something is wrong but I donno how to fix it :(')
      end
  else
    @bot.api.send_message(chat_id: message.chat.id, text: 'are you sure this is a link?')
  end
end

Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_TOKEN']) do |bot|
  @bot = bot
  @bot.listen do |message|
    if is_command?(message)
      handle_command(message)
    else
      handle_message(message)
    end
  end
end

