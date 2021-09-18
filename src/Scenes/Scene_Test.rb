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
