class PolyTreeNode
    def initialize(value)
    @value = value
    @parent = nil
    @children = []
    end

    def parent
        @parent
    end

    def children
        @children
    end

    def value
        @value
    end

    def parent=(node)
        if self.parent
            self.parent.children.delete(self)
        end
            @parent = node
            self.parent.children << self unless self.parent.nil?
        self
    end

    def add_child(child_node)
        child_node.parent=(self)
    end

    def remove_child(child_node)
        raise "No Parent" if !child_node.parent
        child_node.parent=(nil)
    end

    def dfs(target_value)
    if self.value == target_value
        return self
    end

    i = 0
    while i < self.children.length
        current = self.children[i]
        result = current.dfs(target_value)
        if result
            return result
        end
        i += 1
    end
    return nil
    end

    def bfs(target_value)
        array = []
        array << self

        while array.length > 0
            curr = array.shift
            if curr.value == target_value
                return curr
            else
                array += curr.children
            end
        end
        nil

    end


end



class KnightPathFinder
    def initialize(starting_position)
        @considered_positions = [starting_position]
        @current_position = starting_position
        @grid = Array.new(8) {Array.new(8)}
        @starting_position = starting_position 
        build_move_tree
    end

    def build_move_tree
        nodes = []
        @root_node = PolyTreeNode.new(@current_position)
        nodes << @root_node 

        until nodes.empty?
            curr_node = nodes.shift
            current_pos = curr_node.value
                new_move_positions(current_pos).each do |new_position|
                    new_node = PolyTreeNode.new(new_position)
                    curr_node.add_child(new_node)
                    nodes << new_node
                    @considered_positions << new_position
                end
                    
        end

    end

    def find_path(end_pos)
        end_node = @root_node.bfs(end_pos)
        trace_path_back(end_node)
    end 

    def trace_path_back(end_node)
        current_node = end_node 
        path = []

        while current_node
        path << current_node.value 
        current_node = current_node.parent
        end 
    return path
    end 



    def self.valid_moves(pos)

            x, y = pos
            potential_moves = [
                [x - 2, y - 1], [x - 2, y + 1], [x - 1, y - 2], [x - 1, y + 2],
                [x + 1, y - 2], [x + 1, y + 2], [x + 2, y - 1], [x + 2, y + 1]
            ]
        
            potential_moves.select do |move|
                move.all? { |coord| coord.between?(0, 7) }
            end
    end

    # def new_move_positions(pos)
    # potential_positions = []

    # KnightPathFinder.valid_moves(pos).each do |move|
        
    #     if !@considered_positions.include?(move)
    #         @considered_positions << move
    #     else 
    #         potential_positions << move
    #     end
    # end

    # return potential_positions

    # end

    def new_move_positions(pos)
        KnightPathFinder.valid_moves(pos)
          .reject { |new_pos| @considered_positions.include?(new_pos) }
          .each { |new_pos| @considered_positions << new_pos }
      end

end
