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



end