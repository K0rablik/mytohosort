require "curses"
include Curses

@screen = init_screen
noecho
curs_set(0)
stdscr.keypad = true
@sorted = 0
@last = nil

def ask(a, b)
    @screen.clear
    str = a + '    ' + b
    setpos(lines/2, cols/2-a.length-'    '.length/2)
    @screen.addstr(str)
    answer = @screen.getch
    return true, @last = a if answer == Key::LEFT
    return false, @last = b if answer == Key::RIGHT
    return nil if answer == Key::BACKSPACE
    ask(a, b)
end
    
def insert(elem, array, b, e)
    num = e - b
    if num == 0
        array.insert(b, elem)
        @sorted += 1
        return
    end
    center = (b + e) / 2
    if ask(elem, array[center]).nil?
        undo(array)
        insert(@last, array, 0, @sorted)
    elsif !ask(elem, array[center])
        insert(elem, array, center+1, e)
    elsif ask(elem, array[center])
        insert(elem, array, b, center)
    end
    @sorted += 1
end
    
def undo(array)
    if @sorted > 0
        array.delete(@last)
        @sorted -= 1
        @last = nil
    end
end
        
ttosort = Dir.entries('touhous')
ttosort.delete_if { |i| i =~ /\.+/}
tsorted = []

begin
    while @sorted < ttosort.length-1
        insert(ttosort[@sorted], tsorted, 0, @sorted)
    end
ensure
    close_screen
end
    
tsorted.each_index { |i| puts "#{i+1}.#{tsorted[i]}"}