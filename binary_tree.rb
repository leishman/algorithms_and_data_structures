
class Node
	attr_accessor :key, :value, :left_child, :right_child
	attr_reader :tree

	def initialize(key, value, tree = "default")
		@key, @value = key, [value]
		@left_child, @right_child = nil, nil
		@tree = tree
	end

	def leaf?
		return true if @left_child.nil? && @right_child.nil?
	end

end


class BinaryTree

	attr_reader :root

	def initialize
		@root = nil
		@size = 0
	end

	def insert(node)

		if @root.nil?
			@root = node
		else

		prev_ptr = nil
		ptr = @root

		until ptr.leaf? && ptr != @root

			if ptr.key == node.key
				ptr.value << node.value
				return
			end

			prev_ptr = ptr

			if node.key > ptr.key 

				ptr = ptr.right_child 
				if ptr.nil? 
					prev_ptr.right_child = node; return 
				end

			else 

				ptr = ptr.left_child
				if ptr.nil? 
					prev_ptr.left_child = node; return 
				end

			end
		end
			node.key > ptr.key ? ptr.right_child = node : ptr.left_child = node
		end
	end


	def get(key)
		ptr = @root

		until ptr.nil?
			puts "key: #{ptr.key}"
			if key == ptr.key
				return ptr.value
			elsif key > ptr.key
				ptr = ptr.right_child
			else
				ptr = ptr.right_child
			end
		end
		nil
	end

	def delete(key)  # still needs work
		prev_ptr = nil
		ptr = @root

		while true
			if ptr.key == key
				if ptr.leaf?
					deleted_node = ptr
					ptr = nil
					return deleted_node
				end

				if prev_ptr.left_child == ptr

					if ptr.left_child.nil? && !ptr.right_child.nil?
						deleted_node = ptr
						prev_ptr.left_child = ptr.right_child
						return deleted_node
					elsif ptr.right_child.nil? && !ptr.left_child.nil?
						deleted_node = ptr
						prev_ptr.left_child = ptr.left_child
						return deleted_node
					elsif ptr.leaf?
						deleted_node = ptr
						prev_ptr.left_child = nil
						return deleted_node
					else # node to be deleted has two children

					end

				elsif prev_ptr.right_child == ptr

					if ptr.left_child.nil? && !ptr.right_child.nil?
						deleted_node = ptr
						prev_ptr.right_child = ptr.right_child
						return deleted_node
					elsif ptr.right_child.nil? && !ptr.left_child.nil?
						deleted_node = ptr
						prev_ptr.right_child = ptr.left_child
						return deleted_node
					elsif ptr.leaf?
						deleted_node = ptr
						prev_ptr.right_child = nil
						return deleted_node
					end
				end
			end
			if key > ptr.key
				prev_ptr = ptr
				ptr = ptr.right_child
			else
				prev_ptr = ptr
				ptr = ptr.left_child
			end
		end
		deleted_node
	end


	def count(node)
		@size += 1
		if node.leaf?
			return
		end

		if !node.left_child.nil?
			count(node.left_child)
		end

		if !node.right_child.nil?
			count(node.right_child)
		end
	end

	def size
		@size = 0
		count(@root)
		@size
	end
end





