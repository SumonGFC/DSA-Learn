# frozen_string_literal: true

require_relative '../lib/sll.rb'

RSpec.describe SLL do
  describe '#push' do
    context 'with empty list' do
      let(:empty_list) { described_class.new }

      it 'adds new element as head' do
        expect { empty_list.push(:obj) }
          .to change { empty_list.head }
          .from(nil)
          .to(:obj)
      end

      it 'changes number of elements from 0 to 1' do
        expect { empty_list.push(:obj) }
          .to change { empty_list.len }
          .from(0)
          .to(1)
      end

      it 'tail and head point to same object' do
        empty_list.push(:obj)
        expect(empty_list.head).to be (empty_list.tail)
      end
    end

    context 'with filled list' do
      let(:list) do
        sll = described_class.new
        100.times { |i| sll.push(i) }
        sll
      end

      it 'adds new element as head' do
        expect {list.push(100) }
          .to change { list.head }
          .from(99)
          .to(100)
      end

      it 'changes length of list from 100 to 101' do
        expect {list.push(100) }
          .to change { list.len }
          .from(100)
          .to(101)
      end

      it 'does not change tail node' do
        expect {list.push(100) }.not_to change { list.tail }
      end

    end
  end
end
