  <?

  // include the file with all the functions and classes
  
require('lib/xml2tree.inc');


$xmlFile = "xml/arbo.xml";

// read the XML file and store it as an object

$topNode = readXML ($xmlFile);

manageNode("xml/arbo.xml", $topNode,$Selected_node,$action,$input_new_name);

echo "&output=$input_new_name";

		   ?>
