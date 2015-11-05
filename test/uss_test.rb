require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'uss'

describe USS::UniqueSearcher, "the unique string searcher" do

  describe "when run against a words list" do

    let(:word_list) { File.open('test/fixtures/test-words.txt').read }
    let(:uss_params) {{corpus: word_list, length: 4, stems_outfile: 'tmp/stems_file.txt', uniques_outfile: 'tmp/uniques_file.txt'}}
    let(:search) { USS::UniqueSearcher.new(uss_params) }

    it ":uniques should be an array" do
      assert search.uniques.is_a?(Array)
    end

    it ":stems should be an array" do
      assert search.stems.is_a?(Array)
    end

    it ":uniques should include 'syzy'" do
      assert search.uniques.include?("syzy")
    end

    it ":uniques should not include 'summ'" do
      assert !search.uniques.include?("summ")
    end

    it ":stems should not include 'suit'" do
      assert !search.stems.include?("suit")
    end

    it ":stems should not include \"we'd\"" do
      assert !search.stems.include?("we'd")
    end
  end

  after do
    `rm tmp/stems_file.txt`
    `rm tmp/uniques_file.txt`
  end

end
