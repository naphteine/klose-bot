require 'twitter'

load('secrets.rb')

def logger(text)
	puts "#{DateTime.now} #{text}"
	open('logs/klose.log', 'a') { |f|
		f.puts "#{DateTime.now} #{text}"
	}
end

$locations = [
  "Cordon", "Garbage", "Agroprom", "Dark Valley", "Rostok", "Yantar",
  "Army Warehouses", "Red Forest", "Pripyat", "Chernobyl NPP", "Great Swamps",
  "Limansk", "Deserted Hospital", "Zaton", "Dead City", "Darkscape", "Radar"
]

$factions = [
  "Monolith", "Duty", "Freedom", "Military", "Bandits", "Mercenaries", "Clear Sky", "Ecologists"
]

$locationSentences = [
  "Lots of activity going on",
  "Saw lots of Military personnel passing by",
  "Hearing gunshots",
  "I heard some Monolity activity going on",
  "I passed out while sitting on a tree",
  "I can't find anybody"
]

$randomSentences = [
  "I get emotional every time I pass Kindergarten in Pripyat",
  "I too find knives quite useful, but attacking a Bandit, armed with shotgun, using nothing but a knife is outright crazy",
  "Chimera!",
  "Why some Freedom members so interested in hunting Bloodsuckers?",
  "My Kalashnikov acts funny. I hope I don't shoot myself",
  "The old man in the Red Forest said his knees hurt, an emission is drawing near",
  "Stay alert, they are near",
  "We need proper, independent news radio in the Zone but nobody cares how important this is..",
  "I'm hearing a strange song, near the Ferris Wheel. People say it's meditation. I don't know what that means",
  "I should visit my doctor",
  "Last time they forgot to announce emission lots of rookies wiped out. I will not stop telling how important it is to have free, public, accessible news radio for everyone.",
  "He's calling again, 'Come to me...'",
  "I feel really at home when I hear Hawaiian say Aloha!",
  "Code red. Code red. Inform The Major as soon as possible",
  "Nothing beats Soviet songs from 1980s",
  "I was sitting on a tree when I saw two Bandits arguing whose diet sausage was bigger",
  "Sidorovich is not your friend",
  "Some Ecologists jumped on the crypto hype, while stalkers out there can't even recharge their PDAs",
  "There are women in the Zone, but they're hiding their identities because of the fear. We're not only fighting the Monolith, but the evil among us.",
  "Legends say Ashot and Uncle Yar are still dealing to this day"
]

client = Twitter::REST::Client.new do |config|
  config.consumer_key = $consumer_key
  config.consumer_secret = $consumer_secret
  config.access_token = $access_token
  config.access_token_secret = $access_token_secret
end

logger("Klose bot starting...")

begin
  while true
    output = "I'm tired of everything"

    if rand(1..100) < 50
      output = $locationSentences.sample + " in " + $locations.sample
    else
      output = $randomSentences.sample
    end

    logger("TWEETING: " + output)
    client.update(output)
    sleepsecs = 1 * 60 * 60
    logger("SLEEPING: #{sleepsecs} seconds")
    sleep(sleepsecs)
  end
rescue Exception => e
  logger("INTERRUPTED!")
end

logger("Klose bot going down...")