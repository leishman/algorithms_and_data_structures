# Used http://www.brpreiss.com/books/opus8/ as reference

class LinkedList
  attr_accessor :head, :tail

  def initialize
    set_head_tail_nil # set head and tail to nil
  end

  def purge
    set_head_tail_nil # set head and tail to nil
  end

  def empty?
    @head.nil? # Is the head empty?
  end

  def first
    raise ContainerEmpty if @head.nil? # If the list is empty (no head), raise an error
    @head.datum # return the datum from the head Element
  end

  def last
    raise ContainerEmpty if @head.nil?  # If the list is empty (no head), raise an error
    @tail.datum # return the datum from the tail Element
  end

  def prepend(item)
    tmp = Element.new(self, item, @head) # Create new temp Element
    @tail = tmp if @head.nil?      # If there is no head (list is empty), the tail also equals this new Element
    @head = tmp   # Set the head equal to the new element
  end

  def append(item)
    tmp = Element.new(self, item, nil)
    if @head.nil?
      @head = tmp
    else
      @tail.succ = tmp
    end
    @tail = tmp
  end

  # Create shallow copy of the linked list
  def clone
    result = LinkedList.new
    ptr = @head
    while !ptr.nil?  # go through list and create a new list referencing the same Element objects
      result.append(ptr.datum)
      ptr = ptr.succ
    end
    result
  end

  # Remove the first element with datum matching an argument
  def extract(item)
    ptr = @head # set pointer
    prev_ptr = nil # set previous pointer

    while !ptr.nil? && !ptr.datum.equal?(item) # while the pointer is not nil or does not match the element to extract
      prev_ptr = ptr # set the previous pointer equal to the current one
      ptr = ptr.succ # set the current pointer equal to the successor element
    end

    raise ArgumentError if ptr.nil?

    if ptr == @head # if the ptr is the head of the list
      @head = @head.succ # set the new head to the successor of the current head
    else
      prev_ptr.succ = ptr.succ # Otherwise set the successor of the prepending element equal to the successor element
    end

    if ptr == @tail # if the pointer is equal to the tail
      @tail = prev_ptr # Set the tail equal to the prepending Element
    end
  end


# Define Element class. Each Element has a @succ (successor) attribute, which points to
# the next Element in the list
  class Element
    attr_accessor :datum, :succ
    def initialize(list, datum, succ)
      @list = list
      @datum = datum
      @succ = succ
    end


    # define a method to insert a new element after
    def insert_after(item)
      @succ = Element.new(@list, item, @succ)
      if @list.tail.equal?(self)
        @list.tail = @succ
      end
    end

    # define a method to insert a new element after
    def insert_before(item)
      tmp = Element.new(@list, item, self)

      if @list.head == self
        @list.head = tmp
      else
        prev_ptr = @list.head
        while !prev_ptr.nil? && !(prev_ptr.succ == self)
          prev_ptr = prev_ptr.succ
        end
        prev_ptr.succ = tmp
      end
    end
  end

  private
    def set_head_tail_nil
      # @head and @tail are #Element objects
      @head = nil
      @tail = nil
    end

end