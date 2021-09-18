#==============================================================================
# ** Test_Class
#------------------------------------------------------------------------------
#  Class used for tests
#==============================================================================

class Test_Class
   
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Number of tests that passed
  attr_accessor :testsPassed
  # Number of tests that failed
  attr_accessor :testsFailed
  # Number of tests that failed in error
  attr_accessor :testsErrors
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize()
    @testsPassed = 0
    @testsFailed = 0
    @testsErrors = 0
    
    #Tests setup
    testFixtureSetup()
    
    #Tests
    runTests()
    
    #Tests tear down
    testFixtureTearDown()
    
    showTestsStatus()
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Setup tests (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def testFixtureSetup()
  end
  
  #--------------------------------------------------------------------------
  # * Tear down tests (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def testFixtureTearDown()
  end
  
  #--------------------------------------------------------------------------
  # * Run tests
  #--------------------------------------------------------------------------
  def runTests()
    puts ('-' * 75, "Tests for " + self.class.name, '-' * 75)
    test_methods = self.class.public_instance_methods(false).sort
    test_methods = test_methods.select{ |x| x.index("test_") == 0 }

    for test in test_methods
      begin
        if (self.send(test))
          puts "   " + test + " - Passed"
          @testsPassed += 1
        else
          puts " ! " + test + " - Failed"
          @testsFailed += 1
        end
        
      rescue Exception=>e
        puts " * " + test + " - Error: " + e.to_s
        @testsErrors += 1
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Show the status of the tests
  #--------------------------------------------------------------------------
  def showTestsStatus()
    nbTotalTests = @testsPassed + @testsFailed + @testsErrors
    puts ("\n", "Results" ,'-' * 75)
    puts (nbTotalTests.to_s + " test(s), " + 
          @testsPassed.to_s + " passed, " +
          @testsFailed.to_s + " failed, " +
          @testsErrors.to_s + " error(s) ",
          "\n")
  end
  
end
