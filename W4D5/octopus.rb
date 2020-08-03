food = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

def sluggish_octopus(arr)
    biggest = nil

    arr.each do |ele|
        arr.each do |ele2|
            biggest = ele if ele.length >= ele2.length
        end
    end
    biggest
end

def dominant_octopus(arr)
    middle = arr.length /2
    left = arr[0...middle]
    right = arr[middle..-1]

    sorted_left = dominant_octopus(left)
    sorted_right = dominant_octopus(right)

    merge(sorted_left, sorted_right)
end

def merge(left, right)
    sorted = []
    until left.empty? || right.empty?
        if left.first < right.first
            sorted << left.shift
        else
            sorted << right.shift
        end
    end

    sorted + left + right
end

def clever_octopus(arr)
    arr.max
end

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(tile, arr)
    arr.each_with_index { |ele, i| return i if ele == tile}
end

tiles_hash = {"up" => 0, "right-up" => 1, "right" => 2, "right-down" => 3, "down" => 4, "left-down" => 5, "left" => 6,  "left-up" => 7 }

def fast_dance(tile, hash)
    hash[tile]
end
