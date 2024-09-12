# frozen_string_literal: true

require_relative '../lib/array_deque'

describe ArrayDeque do
  describe '#add' do
    context 'with empty queue' do
      let(:empty_deque) { described_class.new }

      it 'inserts element at the head' do
        empty_deque.add(:elmt)
        expect(empty_deque.in_order).to eq [:elmt]
      end

      it 'tail points to head after single insert' do
        expect(empty_deque.head).to eq(empty_deque.tail)
      end

      it 'increments reference to number of elements' do
        expect { (empty_deque.add(0)) }
          .to change {empty_deque.num }
          .from(0)
          .to(1)
      end
    end

    context 'with filled array' do
      shared_context 'common' do
        let(:size) { 10 }
        let(:filled_deque) do
          x = described_class.new
          size.times { |i| x.add(i) }
          x
        end
      end

      context 'when inserting at the ends' do
        include_context 'common'

        it 'adds new element to the head of the array' do
          filled_deque.add(:new_head, 0)
          expect(filled_deque.head).to be :new_head
        end

        it 'adds new element to the tail of the array' do
          filled_deque.add(:new_tail, filled_deque.num)
          expect(filled_deque.tail).to be :new_tail
        end

        it 'increments the reference to number of elements' do
          expect { filled_deque.add(:new) }
            .to change { filled_deque.num }
            .from(size)
            .to(size + 1)
        end
      end

      context 'when inserting in the middle' do
        include_context 'common'
        let(:offset) { 10 }

        it 'properly inserts and preserves order of elements' do
          expected = (0..4).to_a + [:mid]*offset + (5..9).to_a
          offset.times { filled_deque.add(:mid, 5) }
          actual = filled_deque.in_order.compact
          expect(expected).to eq actual
        end

        it 'leaves head unchanged when inserted in the left half' do
          old_head = filled_deque.head
          offset.times { filled_deque.add(:left, 3) }
          new_head = filled_deque.head
          expect(new_head).to be new_head
        end

        it 'leaves tail unchanged when inserted in the right half' do
          old = filled_deque.tail
          offset.times { filled_deque.add(:right, filled_deque.num - 2) }
          new = filled_deque.tail
          expect(new).to be old
        end
      end
    end

  end
end
