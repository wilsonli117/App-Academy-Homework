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
        @queue << el
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
        if get(key) != false
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
        @map
    end

end


    
    
            


