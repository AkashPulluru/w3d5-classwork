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



end