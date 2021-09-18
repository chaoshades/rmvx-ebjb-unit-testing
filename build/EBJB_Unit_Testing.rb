################################################################################
#                       EBJB Unit Testing - EBJB_Unit                 #   VX   #
#                          Last Update: 2013/10/12                    ##########
#                           Author : ChaosHades                                #
#     Source :                                                                 #
#     http://www.google.com                                                    #
#------------------------------------------------------------------------------#
#  Contains common functions and objects to ease unit testing of your project. #
#==============================================================================#
#                         ** Instructions For Usage **                         #
#  There are no configurations for unit testing.                               #
#==============================================================================#
#                                ** Examples **                                #
#  See the documentation in each classes.                                      #
#==============================================================================#
#                           ** Installation Notes **                           #
#  Copy this script in the Materials section                                   #
#==============================================================================#
#                             ** Compatibility **                              #
#  Works With: Script Names, ...                                               #
#  Alias: Class - method, ...                                                  #
#  Overwrites: Class - method, ...                                             #
################################################################################

$imported = {} if $imported == nil
$imported["EBJB_Unit"] = true

#==============================================================================
# ** Scene_Test
#------------------------------------------------------------------------------
#  This class performs the tests processing.
#==============================================================================

class Scene_Test < Scene_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constants
  #//////////////////////////////////////////////////////////////////////////
  MSG = 'Press "Shift+A" to run the tests again, Press "Shift+B" to exit.'
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(testui_class)
    @test_class = testui_class
    
    @text = Sprite.new
    @text.bitmap = Bitmap.new(Graphics.width,Graphics.height)
    @text.bitmap.font.color = Color.new(255,255,255)
    @text.bitmap.draw_text(0,Graphics.height-24,Graphics.width,24,MSG,0)
    @text.z = 10000
  end
  
  #--------------------------------------------------------------------------
  # * Start processing
  #--------------------------------------------------------------------------
  def start
    super
    #Tests setup
    @test_class.testFixtureSetup()
    #Tests
    @test_class.runTests()
    @test_class.showTestsStatus()
  end

  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
  def terminate
    super
    #Tests tear down
    @test_class.testFixtureTearDown()
    @test_class = nil
    @text.dispose
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    @test_class.update
    
    if Input.press?(Input::SHIFT) && Input.trigger?(Input::C)
      @test_class.testFixtureTearDown()
      @test_class.testsPassed = 0
      @test_class.testsFailed = 0
      @test_class.testsErrors = 0
      @test_class.testFixtureSetup()
      @test_class.runTests()
      @test_class.showTestsStatus()
    elsif Input.press?(Input::SHIFT) && Input.trigger?(Input::B)
      return_scene
    end
  end
  
  #--------------------------------------------------------------------------
  # * Return to Original Screen
  #--------------------------------------------------------------------------
  def return_scene
    $scene = Scene_Map.new
  end
end

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

#==============================================================================
# ** TestUI_Class
#------------------------------------------------------------------------------
#  Class used for UI tests
#==============================================================================

class TestUI_Class < Test_Class

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

    $game_temp.next_scene = nil
    $scene = Scene_Test.new(self)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Frame update (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def update()
  end
  
end

