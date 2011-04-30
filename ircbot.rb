#!/usr/bin/env ruby

require 'socket'

class IRCBot

 def initialize(server, port, channel)
  @channel = channel
  @socket = TCPSocket.open(server, port)
  say "Nick PeterSS_bot"
  say "User ircbot 0 * IRCBot"
  say "Join ##{@channel}"
 end

 def say(msg)
  puts msg
  @socket.puts msg
 end

 def say_to_chan(msg)
  say "PRIVMSG  ##{@channel} : #{msg}"
 end

 def run
  until @socket.eof? do
     msg = @socket.gets
     puts msg

     if msg.match(/^PING :(.*)$/)
	say "PONG #{$~[1]}"
        next
     end
 
     if msg.match(/PRIVMSG ##{@channel} :(.*)$/)
	content = $~[1]
	case content.strip
	  when "!hello"
	    say_to_chan("hello sayo bot ako")
	end
     end 
  end
 end

 def quit
   say "PART ##{@channel} : hmmmmmmm"
   say 'QUIT'
 end
end


bot = IRCBot.new("irc.freenode.net", 6667, "phpugph")
trap("INT") { bot.quit }

bot.run
