# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.
class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @list = []
  end

  # ===----------------------=== #
  # Adding items
  # ===----------------------=== #

  def add(todo)
    raise TypeError, "Can only add Todo objects" unless todo.instance_of? Todo
    @list << todo
  end

  alias_method :<<, :add

  # ===----------------------=== #
  # Interrogating the list
  # ===----------------------=== #

  def size
    @list.size
  end

  def first
    @list.first
  end

  def last
    @list.last
  end

  # ===----------------------=== #
  # Retrieving items
  # ===----------------------=== #

  def item_at(index)
    @list[index]
  end

  def find_by_title(title)
    @list.find { |item| item.title == title }
  end

  # ===----------------------=== #
  # Marking items
  # ===----------------------=== #

  def mark_done_at(index)
    @list[index].done!
  end

  def mark_undone_at(index)
    @list[index].undone!
  end

  def all_done!
    @list.each { |item| item.done! }
  end

  # ===----------------------=== #
  # Deleting items
  # ===----------------------=== #

  def shift
    @list.shift
  end

  def pop
    @list.pop
  end

  def remove_at(index)
    @list.delete_at index
  end

  # ===----------------------=== #
  # Iterating over the list
  # ===----------------------=== #

  def each
    iterator = 0

    while iterator < size
      yield(@list[iterator])
      iterator += 1
    end
  end

  # ===----------------------=== #
  # Misc
  # ===----------------------=== #

  def to_s
    title.center(30, '-') + "\n\n" + @list.join("\n")
  end
end

# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.
class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

list.each do |todo|
  puts todo                   # calls Todo#to_s
end
