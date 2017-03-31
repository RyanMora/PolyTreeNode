require 'byebug'


class PolyTreeNode

  attr_accessor :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def parent=(set_parent)
    unless @parent == nil
      @parent.children.delete(self)
    end
    @parent = set_parent
    unless self.parent == nil
      set_parent.children << self unless set_parent.children.include?(self)
    end
  end

  def value
    @value
  end


  def children
    @children
  end

  def add_child(child_node)
    @children << child_node
    child_node.parent=(self)
  end

  def remove_child(child_node)
    raise "That is not a child" if child_node.parent == nil
    @children.delete(child_node)
    child_node.parent=(nil)
  end

  def dfs(target_value)
    return self if self.value == target_value
    result = nil
    children.each do |child|
      break unless result == nil
      result = child.dfs(target_value)
    end
    result
  end


  def bfs(target_value)
    queue = [self]
    until queue.empty?
      first = queue.shift
      return first if first.value == target_value
      first.children.each do |child|
        queue << child
      end
    end
  end

end



a = PolyTreeNode.new(1)
b = PolyTreeNode.new(2)
c = PolyTreeNode.new(3)

a.parent=(b)
c.parent=(b)

p
