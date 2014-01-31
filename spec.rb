require_relative 'binary_tree.rb'



tree = BinaryTree.new

vals = [1,3,2,4]
vals.each_with_index do |x, i|
	node = Node.new(x, x * i)
	tree.insert(node)
end

p tree.root.right_child.left_child.key == 2 

p tree.delete(2) 

p tree.size == 3

tree.insert(Node.new(7, 4))
tree.insert(Node.new(1, 4))
p tree.size == 5
tree.insert(Node.new(1, 4))