 class Stack
    def initialize
      @stack = []
    end

    def push(el)
      @stack << el
    end

    def pop
      @stack.pop
    end

    def peek
      return @stack.last
    end

  end

class Queue
    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue << el (push)
    end

    def dequeue
        @queue.shift
    end

    def peek
        return @queue.first
    end
end

class Map
    attr_accessor :map
    def initialize
        @map = []
    end

    def set(key, value)
        if get(key) #!= false don't even need this condition because get(key) will either be "truthy" or false
            #@map.index {|pair| pair[0] == key } will return nil if it doesn't find it
            @map.each { |pair| pair[1] = value if pair[0] == key }
        else
            @map << [key,value]
        end
    end

    def get(key)
        @map.each { |pair| return pair if pair[0] == key }
        return false
    end
           
    def delete(key)
        @map.each { |pair| @map.delete(pair) if pair[0] == key }
    end

    def show
        deep_dup(@map) #needs to be a deep dup because 
    end

    def deep_dup(arr)
        arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el }
    end

end


    
    
            


