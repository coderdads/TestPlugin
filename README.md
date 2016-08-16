TestPlugin
============

### NOTE: This plugin is Just a TEST

This plugin is a test plugin.

Installation
------------

### For Cordova 3.0.x:

1. To add this plugin just type: `cordova plugin add https://github.com/coderdads/TestPlugin.git` or `phonegap local plugin add https://github.com/coderdads/TestPlugin.git`
2. To remove this plugin type: `cordova plugin remove com.coderdads.TestPlugin` or `phonegap local plugin remove com.coderdads.TestPlugin`

Usage:
------

Call the `window.testPlugin.multiTag()` method using success and error callbacks, strings for the overlays and a json string representation of an array of filenames.

 window.testPlugin.multiTag(
                function(msg){
                    console.log(msg);
                },
                function(err){
                    console.log(err);
                },
                JSON.stringify(imagePaths),
                "Watermark Text",
                "Tag 1",
                "Tag 2",
                "Tag 3"
            );


## License

The MIT License

Copyright (c) 2016 Coder Dads, LLC. (http://github.com/coderdads)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
