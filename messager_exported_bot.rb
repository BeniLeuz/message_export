require 'csv'
require 'discordrb'

bot = Discordrb::Bot.new token: 'DISCORD_BOT_TOKEN'

channel = bot.channel("445316451436462101")
puts channel.name

CSV.open("messages.csv", "w") do |csv|
  csv << ["Id", "Author", "Date", "Message"]


  running = true

  last_msg_id = 1213924158203764836
  counter = 0

  while (running) do
    channel.history(100, last_msg_id).each do |message, index|
      counter += 1
      last_msg_id = message.id
      next if message.content.empty?

      running = false if message.nil?
      csv << [message.id, message.author.username, message.timestamp, message.content]
    end

    puts "current messages haha lol *_*: #{counter}"
  end

  puts "Done with #{counter} messages."
end

bot.run
