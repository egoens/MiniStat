require 'rubygems'
require 'minitest/unit'
require 'ministat' 

class TestMiniStat < MiniTest::Unit::TestCase
  def setup
    @data1 = [34, 47, 1, 15, 57, 24, 20, 11, 19, 50, 28, 37]
    @data2 = [60, 56, 61, 68, 51, 53, 69, 54]                  
    @data3 = File.open('test/data/1.dat').map {|l| l.chomp}
    @data4 = File.open('test/data/2.dat').map {|l| l.chomp}
    @ms1   = MiniStat::Data.new(@data1)
    @ms2   = MiniStat::Data.new(@data2)
    @ms3   = MiniStat::Data.new(@data3)
    @ms4   = MiniStat::Data.new(@data4)
    # we test to within a tolerance to schluff off
    # possible floating point and rounding errors
    @error = 0.001 
  end

  def test_enum
    ms = MiniStat::Data.new([1])
    assert ms.mean == 1
    ms << 2 
    assert ms.mean == 1.5
  end

  def test_iqr
    assert(@ms1.iqr - 25 < @error)
  end                                                   

  def test_mean
    assert(@ms2.mean - 59 < @error)
    assert(@ms3.mean - 2.179 < @error)
    assert(@ms4.mean - 1.878 < @error)
  end

  def test_median
    assert(@ms1.median - 26 < @error)
    assert(@ms3.median - 1.735 < @error)
    assert(@ms3.median - 2.8 < @error)
  end

  def test_mode
    ms = MiniStat::Data.new([1,1,1,2,3,4,5])
    assert_equal(ms.mode, 1)
    ms = MiniStat::Data.new([1,2,2,2,2,3,4,5])
    assert_equal(ms.mode, 2)
  end

  def test_outliers
    assert_equal(@ms1.outliers, [])
  end

  def test_q1
    assert(@ms1.q1 - 17 < @error)   
    assert(@ms3.q1 - 1.05 < @error)
    assert(@ms4.q1 - -2.4 < @error)
  end

  def test_q3
    assert(@ms1.q3 - 42 < @error)
    assert(@ms3.q3 - 2.99 < @error)
    assert(@ms4.q3 - 6.75 < @error)
  end

  def test_std_dev
   assert(@ms2.std_dev - 6.324 < @error)
   assert(@ms3.std_dev - 1.515 < @error)
   assert(@ms4.std_dev - 7.553 < @error)
  end

  def test_geo_mean
    # debugger
  end

  def test_harm_mean
    # debugger
  end
end

# Number of errors detected: 11
