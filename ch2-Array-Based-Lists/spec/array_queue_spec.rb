# frozen_string_literal: true

require_relative '../lib/array_queue'

describe ArrayQueue do
  describe '#initialize' do
    let(:new_queue) { described_class.new }
    let(:result) do
      new_queue.instance_variables.map do |var|
        new_queue.instance_variable_get(var)
      end
    end

    it 'creates array instance variable' do
      expect(result).to include(a_kind_of(Array))
    end

    it 'creates two instance variables with value 0' do
      no_arys = result.reject { |x| x.is_a? Array }
      expect(no_arys).to contain_exactly(0, 0)
    end
  end

  describe '#add' do
    context 'with one element inserted into empty array' do
      let(:empty_queue) { described_class.new }

      it 'inserts element at the head' do
        empty_queue.add(:elmt)
        expect(empty_queue.head).to be :elmt
      end

      it 'tail points to head' do
        empty_queue.add(:elmt)
        expect(empty_queue.tail).to eq (empty_queue.head)
      end

      it 'increments the reference to number of elements' do
        empty_queue.add(0)
        expect(empty_queue.num).to be 1
      end
    end

    context 'with half-filled array' do
      let(:size) { 10 }
      let(:half_filled_queue) do
        x = described_class.new
        size.times { x.add(0) }
        x
      end

      it 'adds new element to the end of the array' do
        half_filled_queue.add(:new)
        expect(half_filled_queue.tail).to be :new
      end

      it 'increments the reference to number of elements' do
        expect { half_filled_queue.add(:new) }
          .to change { half_filled_queue.num }
          .from(size)
          .to(size + 1)
      end
    end

    context 'when one element shy of resizing' do
      let(:queue) { described_class.new }

      it 'resizes the array to twice its previous size' do
        10.times do
          queue.add(0) until queue.len == queue.num
          old_len = queue.len
          queue.add(0)
          new_len = queue.len
          expect(new_len).to eq(2 * old_len)
        end
      end
    end
  end

  describe '#remove' do
    context 'with empty queue' do 
      let(:empty_queue) { described_class.new }

      it 'leaves the queue unchanged and returns nil' do
        res = empty_queue.remove
        expect(res).to be nil
      end

      it 'leaves head pointer and number of elements unchanged' do
        empty_queue.remove
        expect(empty_queue.head_ptr).to eq 0
        expect(empty_queue.num).to eq 0
      end
    end

    context 'with filled queue and head_ptr offset' do
      let(:filled_queue) do
        x = described_class.new
        10.times { |i| x.add(("item#{i}").to_sym) }
        3.times { x.remove }
        x
      end

      it 'removes and returns the head of the list' do
        res = filled_queue.remove
        expect(res).to be :item3
      end

      it 'increments head pointer' do
        old_head = filled_queue.head_ptr
        expect { filled_queue.remove }
          .to change { filled_queue.head_ptr }
          .from(old_head)
          .to(old_head + 1)
      end

      it 'decrements number of elements' do
        old_num = filled_queue.num
        expect { filled_queue.remove }
          .to change { filled_queue.num }
          .from(old_num)
          .to(old_num - 1)
      end
    end

    context 'with a big filled queue' do
      let(:big_queue) do
        x = described_class.new
        (2**10).times do |i|
          x.add(i)
        end
        x
      end

      it 'resizes when number of elements is one-third of array size' do
        until big_queue.num == 1
          old_size = big_queue.len
          big_queue.remove
          new_size = big_queue.len
          if big_queue.num <= old_size / 3
            expect(new_size).to eq(2 * big_queue.num)
          end
        end
      end
    end
  end
end
