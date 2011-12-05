# Cuukie

Cuukie shows your Cucumber results on a web page.

[![Build Status](https://secure.travis-ci.org/nusco/cuukie.png)](http://travis-ci.org/nusco/cuukie.png)

## Using it

Install Cuukie:

    gem install cuukie

(Or better still, you can use Bundler).

Require Cuukie from any file in your _features/support_ directory:

    require 'cuukie'

Start the Cuukie server from a terminal window:

    cuukie_server

Leave the server running. When you run Cucumber, ask it to use the _cuukie_ formatter:

    cucumber --format cuukie
    
To look at the results, open this page in a browser:

    http://localhost:4569

## Cuukie Vision

Right now, Cuukie is not any more useful than Cucumber's own HTML formatter. My plan is to make it more dynamic. You'll be able to see your steps as they run, just like you do with the default command-line formatter - but on a web page. Cuukie wants to be a good choice both when you want to run Cucumber tests locally, and when you want to show Cucumber tests on your build machine.

## License

MIT License. Copyright (c) 2011 Paolo "Nusco" Perrotta.
