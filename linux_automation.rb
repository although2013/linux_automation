
#`sudo apt-get install imagemagic`


image1 = "screenshot1.jpg"
image2 = "screenshot2.jpg"

#window = `xdotool selectwindow`
#make_focus = `xdotool windowfocus --sync #{window}`

refresh = [147, 85]
hold = [699, 588]
change = [696, 557]


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
  del = `compare -metric AE -fuzz 5% #{image1} #{image2} null: 2>&1`
  return true if del.to_i < 100
  false
end


loop
  capture image1
  sleep 5
  capture image2
  if same?(image1, image2)
    mouse_move refresh
    click_left
    sleep 8
    mousemove hold
    click_left
    mousemove change
    click_left
  end
  sleep 2
end
