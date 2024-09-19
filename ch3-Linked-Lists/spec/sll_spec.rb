# frozen_string_literal: true

require_relative '../lib/sll.rb'

RSpec.describe SLL do
  describe '#add_first' do
    context 'with empty list' do
      let(:empty_list) { described_class.new }

      it 'adds new element as head' do
        expect { empty_list.add_first(:obj) }
          .to change { empty_list.head }
          .from(nil)
          .to(:obj)
      end

      it 'changes number of elements from 0 to 1' do
        expect { empty_list.add_first(:obj) }
          .to change { empty_list.len }
          .from(0)
          .to(1)
      end

      it 'tail and head point to same object' do
        empty_list.add_first(:obj)
        expect(empty_list.head).to be (empty_list.tail)
      end
    end

    context 'with filled list' do
      let(:list) do
        sll = described_class.new
        100.times { |i| sll.add_first(i) }
        sll
      end

      it 'adds new element as head' do
        expect {list.add_first(100) }
          .to change { list.head }
          .from(99)
          .to(100)
      end

      it 'changes length of list from 100 to 101' do
        expect {list.add_first(100) }
          .to change { list.len }
          .from(100)
          .to(101)
      end

      it 'does not change tail node' do
        expect { list.add_first(100) }.not_to change { list.tail }
      end
    end
  end

  describe '#remove_first' do
    context 'with empty list' do
      let(:empty_list) { described_class.new }

      it 'returns nil' do
        expect(empty_list.remove_first).to be nil
      end

      it 'does not change length of list' do
        expect { empty_list.remove_first }.not_to change { empty_list.len }
      end

      it 'leaves head as nil' do
        expect { empty_list.remove_first }.not_to change { empty_list.head }
      end

      it 'leaves tail as nil' do
        expect { empty_list.remove_first }.not_to change { empty_list.tail }
      end

      it 'leaves the entire list empty' do
        before = empty_list.to_a
        empty_list.remove_first
        after = empty_list.to_a
        expect(before).to eq after
      end
    end

    context 'with filled list' do
      let(:filled_list) do
        x = described_class.new
        10.times { |i| x.add_first(i) }
        x
      end

      it 'returns head' do
        head = filled_list.head
        removed = filled_list.remove_first
        expect(removed).to be head
      end

      it 'reduces length of list by 1' do
        old_len = filled_list.len
        filled_list.remove_first
        new_len = filled_list.len
        expect(old_len).to eq (new_len + 1)
      end

      it 'modifies head pointer to next item in list' do
        next_item = filled_list.head_ptr.next
        filled_list.remove_first
        expect(next_item).to be filled_list.head_ptr
      end

      it 'does not change tail' do
        old_tail = filled_list.tail_ptr
        filled_list.remove_first
        new_tail = filled_list.tail_ptr
        expect(old_tail).to be new_tail
      end
    end
  end

  describe '#add_last' do
  end

  describe '#remove_last' do
  end

  describe '#get' do
  end

  describe '#set' do
  end

  describe '#contains?' do
  end

  describe '#find' do
  end
end
