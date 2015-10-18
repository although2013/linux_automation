
$image1 = "screenshot1.jpg"
$image2 = "screenshot2.jpg"



def getmouselocation
  str = `xdotool getmouselocation`
  str =~ /x:(\d+)\s+y:(\d+)/
  [$1, $2]
end


def click_left
  `xdotool click 1`
end

def mouse_move(array)
  `xdotool mousemove --sync #{array[0]} #{array[1]}`
end

def capture(image)
  `import -window root #{image}`
end

def same?(iamge1, image2)
  del = `compare -metric AE -fuzz 5% #{$image1} #{$image2} null: 2>&1`
  return true if del.to_i < 100
  false
end

puts "get refresh 5s after"
sleep 5
refresh = getmouselocation
puts "get hold 5s after"
sleep 5
hold    = getmouselocation
puts "get change 5s after"
sleep 5
change  = getmouselocation

loop do
  capture $image1
  sleep 5
  capture $image2
  if same?($image1, $image2)
    puts "same"
    mouse_move refresh
    click_left
    sleep 25
    mouse_move hold
    click_left
    mouse_move change
    click_left
  else
    puts "not same"
  end
  sleep 2
end
