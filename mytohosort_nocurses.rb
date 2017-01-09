@sorted = 0
@last_ans = nil
@last_state = []
@tsorted = []

def ask(a, b)
    @last_state << a << b <<
    str = a + '   ' + b
    puts str
    answer = gets.chomp
    return true, @last_ans = a if answer == '1' 
    return false, @last_ans = b if answer == '2'
    return nil if answer == 'q' && !@last_ans.nil?
    ask(a, b)
end
    
def insert(elem, array, b, e)
    num = e - b
    if num == 0
        array.insert(b, elem) 
        return
    end
    center = (b + e)/2
    print array, "\n", @last_state, "\n", @last_ans, "\n"
    unless (answer = ask(elem, array[center])).nil?
        
        if answer[0]
            insert(elem, array, b, center)
        else
            insert(elem, array, center+1, e)
        end
    else
        unless (array - @last_state).empty?
            array.delete(@last_ans)
        end
        @sorted -= 1
        last_ans = @last_ans
        @last_ans = nil
        insert(last_ans, array, 0, @sorted)
    end
end
    
ttosort = Dir.entries('touhous')
ttosort.delete_if { |i| i =~ /\.+/ }

while @sorted <= ttosort.length-1
    insert(ttosort[@sorted], @tsorted, 0, @sorted)
    @sorted += 1
end
    
@tsorted.each_index { |i| puts "#{i+1}.#{@tsorted[i]}" }