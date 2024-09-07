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
  end
end

