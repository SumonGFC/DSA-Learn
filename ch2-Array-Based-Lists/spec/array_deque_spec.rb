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
        expect(empty_deque.head).to eq (empty_deque.tail)
      end

      it 'increments the reference to number of elements' do
        empty_deque.add(0)
        expect(empty_deque.num).to be 1
      end
    end

    context 'with half-filled array' do
      context 'when inserting at the ends' do
        let(:size) { 10 }
        let(:half_filled_deque) do
          x = described_class.new
          size.times { |i| x.add("old#{i}".to_sym) }
          x
        end

        it 'adds new element to the head of the array' do
          half_filled_deque.add(:new_head, 0)
          expect(half_filled_deque.head).to be :new_head
        end

        it 'adds new element to the tail of the array' do
          half_filled_deque.add(:new_tail, half_filled_deque.num)
          expect(half_filled_deque.tail).to be :new_tail
        end

        it 'increments the reference to number of elements' do
          expect { half_filled_deque.add(:new) }
            .to change { half_filled_deque.num }
            .from(size)
            .to(size + 1)
        end
      end
    end
  end
end
