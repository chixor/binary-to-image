String hiddenMessage = "";
String[] lines;

String conversionCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()-=+[]\\{}|;':\",./<>? \n";
String[] binaryMapping = new String[conversionCharacters.length()];

color one = color(0,0,0);
color zero  = color(255,255,255);

int width = 200;
int height = 324;

void setup() {
  size(width,height);
  lines = loadStrings(sketchPath + "/../stillalive.txt");

  for (int i = 0 ; i < lines.length; i++) {
    hiddenMessage += lines[i];
  }
  
  // build binary mapping (more efficient to just do array lookups rather than binary() every time)
  for(int x=0; x < conversionCharacters.length(); x++) {
    binaryMapping[x] = binary(conversionCharacters.charAt(x)).substring(8);
    println(conversionCharacters.charAt(x) + ": " + binaryMapping[x]);
  }
  
  // convert message into binary
  String messageBinary = "";
  for(int x=0; x < hiddenMessage.length(); x++) {
    int loc = conversionCharacters.indexOf(hiddenMessage.charAt(x));
    if(loc > -1) {
      messageBinary += binaryMapping[loc];
    }
    //println(messageBinary);
  }
  
  // draw binary to screen
  int charpos = 0;

  for(int traverseHeight = 0; traverseHeight < height; traverseHeight++) {
    for(int traverseWidth = 0; traverseWidth < width; traverseWidth++) {
      if(messageBinary.charAt(charpos) == '1') {
        set(traverseWidth, traverseHeight, one);
      }
      if(messageBinary.charAt(charpos) == '0') {
        set(traverseWidth, traverseHeight, zero);
      }

      charpos++;
      if(charpos >= messageBinary.length()) {
        charpos = 0; //messageBinary.length()-1;
      }
    }
  }
}

void draw(){

}
