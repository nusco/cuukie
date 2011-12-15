# Cuukie

Cuukie shows your Cucumber results on a web page.

[![Build Status](https://secure.travis-ci.org/nusco/cuukie.png)](http://travis-ci.org/nusco/cuukie.png)

Install Cuukie via Bundler, or directly with:

    gem install cuukie

Go to your Cucumber folder and add this line to any file in _features/support_:

    require 'cuukie'

Run Cuukie:

    cuukie --showpage

Cuukie passes any command-line argument that it doesn't recognize to Cucumber, so just use _cuukie_ instead of _cucumber_ when you want Cuukie to kick in.

## Advanced Cuuking

Cuukie is actually two things: a server that displays running features on a web page, and a Cucumber formatter that sends data to the server. You can run these two components independently. For example, you might want to keep the server running all the time:

    cuukie --server

When you run Cucumber, ask it to use the _cuukie_ formatter to send data to the server:

    cucumber --format cuukie

To look at the results, visit:

    http://localhost:4569

You can pick a port when you start the cuukie server...

    cuukie --server --cuukieport 4570

...and you can tell the cuukie formatter where to look for the server:

    cucumber --format cuukie CUUKIE_SERVER=http://my.server:4570

This stuff is useful if you want to put the Cuukie server on your build machine.

For more options:

    cuukie --server

Enjoy!

## License

MIT License. Copyright (c) 2011 Paolo "Nusco" Perrotta. I also ripped a few lines of code off Cucumber's HTML formatter.
