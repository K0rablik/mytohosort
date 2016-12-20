require "curses"
include Curses

@screen = init_screen
noecho
curs_set(0)
stdscr.keypad = true

def ask(a, b)
    @screen.clear
    str = a + '    ' + b
    setpos(lines/2, cols/2-a.length-'    '.length/2)
    @screen.addstr(str)
    answer = @screen.getch
    return true if answer == Key::LEFT
    return false if answer == Key::RIGHT
    return nil if answer == Key::BACKSPACE
    ask(a, b)
end
    
def insert(elem, array, b, e, counter)
    num = e - b
    if num == 0
        array.insert(b, elem)
        return
    end
    center = (b + e) / 2
    if ask(elem, array[center]).nil?
        undo(elem, array, array.length-1)
        insert(elem, array, 0, sorted, counter)
    elsif !ask(elem, array[center])
        insert(elem, array, center+1, e)
    elsif ask(elem, array[center])
        insert(elem, array, b, center)
    end
    counter += 1
    e += 1
end
    
def undo(elem, array, sorted, counter)
    if sorted > 0
        array.delete(elem)
        counter -=1
        sorted -= 1
    end
end
        
ttosort = Dir.entries('touhous')
ttosort.delete_if { |i| i =~ /\.+/}
tsorted = []
sorted = 0
i = 0

begin
    while i < ttosort.length-1
        insert(ttosort[i], tsorted, 0, sorted, i)
    end
ensure
    close_screen
end
    
tsorted.each_index { |i| puts "#{i+1}.#{tsorted[i]}"}