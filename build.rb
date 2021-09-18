module EBJB_Unit_Testing
  # Build filename
  FINAL   = "build/EBJB_Unit_Testing.rb"
  # Source files
  TARGETS = [
	"src/Script_Header.rb",
    "src/Scenes/Scene_Test.rb",
    "src/Misc Objects/Test_Class.rb",
    "src/Misc Objects/TestUI_Class.rb",
  ]
end

def ebjb_build
  final = File.new(EBJB_Unit_Testing::FINAL, "w+")
  EBJB_Unit_Testing::TARGETS.each { |file|
    src = File.open(file, "r+")
    final.write(src.read + "\n")
    src.close
  }
  final.close
end

ebjb_build()