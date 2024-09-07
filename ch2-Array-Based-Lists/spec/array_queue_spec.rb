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
    let(:empty_queue) { described_class.new }
    context 'with empty array' do
      xit 'inserts element at the head' do
      end

      xit 'increments the reference to number of elements' do
      end
    end

    context 'with half-filled array' do
      xit 'adds new element to the end of the array' do
      end

      xit 'increments the reference to number of elements' do
      end
    end

    context 'with a full array' do
      xit 'resizes the array to twice its previous size' do
      end
    end
  end
end
