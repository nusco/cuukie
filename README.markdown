# Cuukie

Cuukie shows your Cucumber results on a web page.

[![Build Status](https://secure.travis-ci.org/nusco/cuukie.png)](http://travis-ci.org/nusco/cuukie.png)

## Using it

Install Cuukie via Bundler, or directly with:

    gem install cuukie

Require Cuukie from any file in your _features/support_ directory:

    require 'cuukie'

Add this line to any Ruby file in your _features/support_ directory:

    require 'cuukie'

Run Cuukie:

    cuukie --showpage

## Advanced Cuuking

Cuukie is actually two things: a server that shows you the Cucumber results on a web page, and a Cucumber formatter that sends data to the server. You can run these two components independently (for example, you might want to keep the server running all the time).

To run Cuukie as a server:

    cuukie --server

When you run Cucumber, ask it to use the _cuukie_ formatter to send data to the server:

    cucumber --format cuukie

To look at the results, visit:

    http://localhost:4569

You can pick a port when you start the cuukie server...

    cuukie --server --cuukieport 4570

...and you can tell the cuukie formatter where to look for the server:

    cucumber --format cuukie CUUKIE_SERVER=http://my.server:4570

## Cuukie Vision

Right now, Cuukie is not any more useful than Cucumber's own HTML formatter. My plan is to make it more dynamic. You'll be able to see your steps as they run, just like you do with the default command-line formatter - but on a web page. Cuukie wants to be a good choice both when you want to run Cucumber tests locally, and when you want to show Cucumber tests on your build machine.

## License

MIT License. Copyright (c) 2011 Paolo "Nusco" Perrotta. I ripped a few lines of code off Cucumber's HTML formatter.
