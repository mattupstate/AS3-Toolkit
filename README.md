# AS3-Toolkit

### A collection of goodies for building ActionScript 3 apps. 

It contains a wide array of utilities and abstracted UI classes that can increase your producitivty.

Import the library into your project source, or compile the SWC file and include that instead.

To generate documentation, compile the swc or run the unit tests, create a file named user.properties and define the path to the Flex SDK. For example:

    FLEX_HOME = /Users/Matt/SDK/Flex/4.1
      
Build/compile the SWC

    ant build

Run unit tests:

    ant test

Create documentation:

    ant docs
