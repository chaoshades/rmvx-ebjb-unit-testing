module EBJB_Unit_Testing_Ext
  # Build filename
  FINAL   = "build/EBJB_Unit_Testing_Ext.rb"
  # Source files
  TARGETS = [
    "src/External Scripts/Console Output.rb",
  ]
end

def ebjb_build_ext
  final = File.new(EBJB_Unit_Testing_Ext::FINAL, "w+")
  EBJB_Unit_Testing_Ext::TARGETS.each { |file|
    src = File.open(file, "r+")
    final.write(src.read + "\n")
    src.close
  }
  final.close
end

ebjb_build_ext()