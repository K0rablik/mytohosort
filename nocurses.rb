@sorted = 0
@counter = 0
@last = nil

def ask(a, b)
    puts "@last = #{@last}"
    str = a.to_s + '    ' + b.to_s
    puts str
    answer = gets.chomp
    if answer == '1'
        @last = a 
        @sorted += 1
        return true
    elsif answer == '2'
        @last = b
        @sorted += 1
        return false
    elsif answer.nil?
        @last = nil
        @sorted -= 1
        return nil
    end
    ask(a, b)
end
    
def insert(elem, array, b, e)
    num = e - b
    if num == 0
        array.insert(b, elem)
        return
    end
    center = (b + e) / 2
    if ask(elem, array[center])[0].nil?
        undo(array)
        insert(@last, array, 0, @sorted)
    elsif !ask(elem, array[center])[0]
        insert(elem, array, center+1, e)
    elsif ask(elem, array[center])[0]
        insert(elem, array, b, center)
    end
end
    
def undo(array)
    unless @last.nil?
        array.delete(@last)
    end
end
        
ttosort = Dir.entries('touhous')
ttosort.delete_if { |i| i =~ /\.+/}
tsorted = []

while @sorted < ttosort.length-1
    insert(ttosort[@sorted], tsorted, 0, @sorted)
end
    
tsorted.each_index { |i| puts "#{i+1}.#{tsorted[i]}"}