@sorted = 0
@last = nil

def ask(a, b)
    str = a + '   ' + b
    puts str
    answer = gets.chomp
    return true, @last = a if answer == '1' 
    return false, @last = b if answer == '2'
    return nil if answer == 'q'
    ask(a, b)
end
    
def insert(elem, array, b, e)
    num = e - b
    if num == 0
        array.insert(b, elem) 
        return
    end
    center = (b + e)/2
    puts @last
    if ask(elem, array[center])[0] == true
        insert(elem, array, b, center)
    elsif ask(elem, array[center])[0] == false
        insert(elem, array, center+1, e)
    elsif ask(elem, array[center]).nil?
        array.delete(@last)
        @sorted -= 1
        insert(@last, array, 0, @sorted)
        @last = nil
    end
end
    

    
ttosort = Dir.entries('touhous')
ttosort.delete_if { |i| i =~ /\.+/ }
tsorted = []

while @sorted <= ttosort.length-1
    insert(ttosort[@sorted], tsorted, 0, @sorted)
    @sorted += 1
end
    
tsorted.each_index { |i| puts "#{i+1}.#{tsorted[i]}" }