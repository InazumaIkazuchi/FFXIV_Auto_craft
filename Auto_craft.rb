require './Oshite/Oshite.rb'
require './Oshite/Vkc.rb'

$DELAY = 5;
$CRAFT_TIME = 45;
$stop = false;
$runner_thread;
$listener_thread;

if(ARGV.length == 0)
	puts 'ERROR: no arguments';
	return -1;
end

def runner
	until $stop do
		puts '>>>>>>>> START <<<<<<<<';
		
		Oshite::press(Vkc::VK_NUMPAD0);
		sleep(1);
		Oshite::press(Vkc::VK_NUMPAD0);
		sleep(1);
		Oshite::press(Vkc::VK_NUMPAD0);
		
		sleep(2);
		
		for i in 0..(ARGV.length - 1)
			key = ARGV[i][0].upcase
			puts '>>> Macro #' + i.to_s + ' Key: ' + key + ' <<<';
			Oshite::press(key.ord);
			sleep($CRAFT_TIME)
		end
		
		puts '>>>>>>>>  END  <<<<<<<<';
		sleep(3)
	end
end


def listener
	until $stop do
		str = STDIN.gets;
		if(str[0].downcase == 'x')
			$stop = true;
		end
	end
	puts '>>> EXIT'
	puts '>>> THANK YOU FOR USING!'
	$runner_thread.exit;
end

puts ">>> Auto_craft by InazumaIkazuchi <<<"
puts ">>> Please switch to your game...\n>>> Starting in..."
for i in 0..$DELAY
	puts '>>> ' + ($DELAY - i).to_s;
	sleep(1)
end

$listener_thread = Thread.new {listener};
$runner_thread = Thread.new {runner};

$listener_thread.join;
$runner_thread.join;


