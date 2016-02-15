require 'minitest/autorun'
require 'minitest/reporters'
require 'simplecov'

SimpleCov.start
Minitest::Reporters.use!

require_relative 'todo_list'

class TodoListTest < MiniTest::Test
  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new('clean room')
    @todo3 = Todo.new('go to gym')
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    shifted_todo = @list.shift
    assert_equal(@todo1, shifted_todo)
    assert_equal(2, @list.size)
  end

  def test_pop
    popped_todo = @list.pop
    assert_equal(@todo3, popped_todo)
    assert_equal(2, @list.size)
  end

  def test_done?
    assert(!@list.done?)
    @list.done!
    assert(@list.done?)
  end

  def test_wrong_type
    assert_raises(TypeError) do
      @list << 0
    end
  end

  def test_add_alias
    new_item = Todo.new('drink beer')
    @list << new_item
    todos = @todos << new_item

    assert_equal(todos, @list.to_a)
  end

  def test_item_at
    item_at_zero = @list.item_at 0
    assert_equal(@todo1, item_at_zero)

    assert_raises(IndexError) do
      @list.item_at 100
    end
  end

  def test_mark_done_at
    @list.mark_done_at(0)
    assert @list.item_at(0).done?

    assert_raises(IndexError) do
      @list.mark_done_at 100
    end
  end

  def test_mark_undone_at
    @todo1.done!
    @todo2.done!
    @todo3.done!

    @list.mark_undone_at 0

    assert !@todo1.done?
    assert @todo2.done?
    assert @todo3.done?

    assert_raises(IndexError) do
      @list.mark_undone_at 100
    end
  end

  def test_done!
    @list.done!

    assert @todo1.done?
    assert @todo2.done?
    assert @todo3.done?
    assert @list.done?
  end

  def test_remove_at
    @list.remove_at(1)

    assert_equal(2, @list.size)
    assert_equal(@todo1, @list.item_at(0))
    assert_equal(@todo3, @list.item_at(1))

    assert_raises(IndexError) do
      @list.remove_at(100)
    end
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    --------Today's todos---------
    [ ] Buy milk
    [ ] clean room
    [ ] go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

    @todo2.done!

    output_with_one_done = <<-OUTPUTONEDONE.chomp.gsub /^\s+/, ''
    --------Today's todos---------
    [ ] Buy milk
    [X] clean room
    [ ] go to gym
    OUTPUTONEDONE

    assert_equal(output_with_one_done, @list.to_s)

    @todo1.done!
    @todo3.done!

    output_all_done = <<-OUTPUTALLDONE.chomp.gsub /^\s+/, ''
    --------Today's todos---------
    [X] Buy milk
    [X] clean room
    [X] go to gym
    OUTPUTALLDONE

    assert_equal(output_all_done, @list.to_s)
  end

  def test_each
    new_array = []
    @list.each do |item|
      new_array << item
    end

    assert_equal(@todos, new_array)
  end

  def test_select
    @todo1.done!
    test_list = TodoList.new("Today's todos")
    test_list << @todo1

    new_list = @list.select { |item| item.done? }
    assert_equal(test_list.title, new_list.title)
    assert_equal(test_list.to_s, new_list.to_s)
  end
end
