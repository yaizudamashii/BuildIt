How to run the code:
1. Clone this repository with 
$ git clone git@github.com:yaizudamashii/BuildIt.git

2. open BuildIt.xcworkspace in Xcode
3. Click on the run button in Xcode.  No pod building is needed, they are all checked in
4. If you want to simulate location, you can edit the scheme and simulate to different locations.
To run the code on device will require provisioning profiles with the device included.

To be implemented with more time
1. More tests, especially around the API, using InstantMock and stubbing networks responses... omitted in the interest of time
2. Automatically determine celcius or fahrenheit is used in the device
3. I would stay away from working on the UI too much without designer's input.
4. OpenWeatherAPI provides much more information than what is shown.  Perhaps some ways to display those data.
