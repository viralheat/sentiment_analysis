XML_FIXTURES_DIR = SPECS_DIR + '/fixtures'

def xml_fixture(filename)
  filepath = "#{XML_FIXTURES_DIR}/#{filename}"
  File.read(filepath)
end