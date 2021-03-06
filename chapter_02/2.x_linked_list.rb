# CtCi 2.x
#   Create a linked-list class and test it
#   Used for CtCI Chapter 2 problems... and others
#

require'spec_helper'
require_relative '../linked_list'

puts "============ linkedlist specs =============="

describe Node do
  it "is properly initialized" do
    node = Node.new("test",nil)
    expect(node.data).to eq "test"
    expect(node.next).to eq nil
  end

  it "accepts an optional attribute" do
    node = Node.new("test",nil,:color => "blue")
    expect(node.color).to eql "blue"
  end

  it "accepts multiple optional attributes" do
    node = Node.new("test",nil,:color => 'red', :xpos => 5, :ypos => 0.5)
    expect(node.color).to eql "red"
    expect(node.xpos).to eql 5
    expect(node.ypos).to eql 0.5
  end
end
describe LinkedList do
  it "initializes properly" do
    llist = LinkedList.new("test2")
    expect(llist.head.data).to eq "test2"
    expect(llist.head.next).to be_nil
  end
  it "adds a back node successfully" do
    llist = LinkedList.new("test3")
    llist.addLast(Node.new("linked item #1"))
    expect(llist.head.data).to eq "test3"
    expect(llist.head.next.data).to eq "linked item #1"

  end
  it "adds a front node successfully" do
    llist = LinkedList.new("test4")
    llist.addFirst(Node.new("linked item #2"))
    expect(llist.head.data).to eq "linked item #2"
    expect(llist.head.next.data).to eq "test4"
  end

  describe "handles multiple elements" do
    before(:each) do
      @llist = LinkedList.new("head")
      @llist.addLast(Node.new("one"))
      @llist.addLast(Node.new("two"))
      @llist.addLast(Node.new("three"))
    end
    it "prints the full list" do
      llist = LinkedList.new("test5")
      llist.addFirst(Node.new("first #1"))
      llist.addLast(Node.new("last #1"))
      llist.addLast(Node.new("last #2"))
      expect(llist.recursive_print).to eq "first #1 > test5 > last #1 > last #2"
      puts llist.recursive_print
    end
    it "removes an entry" do
      @llist.remove("two")
      expect(@llist.recursive_print).to eq "head > one > three"
      puts @llist.recursive_print
    end
    it "finds an entry when present" do
      node = @llist.find("two")
      expect(node.data).to eq "two"
    end
    it "returns nil when attempting find an element that is not present" do
      node = @llist.find "four"
      expect(node).to be_nil
    end
    it "removes duplicates (based on data) from a list" do
      #CtCI 2.1
      @llist.addLast(Node.new("one"))
      @llist.addLast(Node.new("two"))
      @llist.addLast(Node.new("four"))
      @llist.remove_dups()
      expect(@llist.recursive_print).to eq "head > one > two > three > four"
    end
    it "removes the kth to last element from a list" do
      #CtCI 2.2 - misread to 'delete'
      @llist.addLast(Node.new("four"))
      @llist.addLast(Node.new("five"))
      @llist.addLast(Node.new("six"))
      @llist.remove_kth_from_last(2)
      expect(@llist.recursive_print).to eq "head > one > two > three > four > six"
    end
    it "finds the kth to last element from a list" do
      #CtCI 2.2
      @llist.addLast(Node.new("four"))
      @llist.addLast(Node.new("five"))
      @llist.addLast(Node.new("six"))
      @llist.recursive_print
      node = @llist.find_kth_from_last(2)
      expect(node.data).to eq "five"
    end
    it "raises exception if attempt to delete 'isolated' node at end of list" do
      @list = LinkedList.new(Node.new("head"))
      @list.addLast(Node.new("last"))
      expect {
        @list.remove_node(@list.find_kth_from_last(1))
      }.to raise_exception "Can't remove isolated last node"
    end
    it "removes a node from list using remove_node" do
      node = @llist.find_kth_from_last(2)
      @llist.remove_node(node)
      expect(@llist.recursive_print).to eq "head > one > three"
    end
  end

  describe "define get_first & get_last methods" do
    before(:each) do
      @list = LinkedList.new("head")
      puts @list.recursive_print
      @list.addLast(Node.new("one"))
      puts @list.recursive_print
      @list.addLast(Node.new("two"))
      puts @list.recursive_print
      @list.addLast(Node.new("three"))
      puts @list.recursive_print
    end

    it "returns the first node on the list using get_first" do
      node = @list.get_first
      expect(node.data).to eql "one"
    end

    it "returns the last node on the list using get_last" do
      @list.recursive_print
      node = @list.get_last
      expect(node.data).to eql "three"
    end
  end

end
