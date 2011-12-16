# Cuukie

Cuukie shows your Cucumber results on a web page.

[![Build Status](https://secure.travis-ci.org/nusco/cuukie.png)](http://travis-ci.org/nusco/cuukie.png)

Install Cuukie via Bundler, or directly with:

    gem install cuukie

Go to a folder where you would normally run _cucumber_, and run _cuukie_ instead:

    cuukie --showpage

# Command Line Arguments

Cuukie passes arguments that it doesn't recognize to Cucumber, so feel free to mix Cuukie arguments and Cucumber arguments:

    cuukie --showpage --dry-run --format pretty --out out.txt

Only thing to notice: Cuukie uses its own Cucumber formatter, so remember to use --out if you want to use additional formatters. 

For more options:

    cuukie --help

## Advanced Cuuking

Cuukie is actually two things: a server that displays running features on a web page, and a Cucumber formatter that sends data to the server. You can run these two components separately. For example, you might want to keep the server running all the time:

    cuukie --server

You can visit the server on port 4569 by default.

Now you need to tell Cucumber about the Cuukie formatter. Go to your Cucumber folder and add this line to any file in _features/support_:

    require 'cuukie'

When you run Cucumber, ask it to use the _cuukie_ formatter to send data to the server:

    cucumber --format cuukie

## Even More Advanced Cuuking

Maybe you want to run the Cuukie server on your build machine. You can pick a port when you start the cuukie server...

    cuukie --server --cuukieport 4570

...and you can tell the cuukie formatter where to look for the server:

    cucumber --format cuukie CUUKIE_SERVER=http://my.server:4570

Enjoy!

## License

MIT License. Copyright (c) 2011 Paolo "Nusco" Perrotta. I also ripped a few lines of code off Cucumber's HTML formatter.
