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
        expect {list.add_first(100) }.not_to change { list.tail }
      end

    end
  end
end
