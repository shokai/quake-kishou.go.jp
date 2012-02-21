quake kishou.go.jp
==================
download japanese quake data

* Ruby 1.8.7+
* MongoDB 2.0+


Install Dependencies
--------------------

    % gem install bundler
    % bundle install


Config
------

    % cp sample.config.yml config.yml


Store
-----

    % ruby -Ku bin/store.rb
    % ruby -rdate -e 'd=Date.parse("2012-01-01");loop do puts d; d+=1; break if d >= Date.today end' | xargs -n1 ruby -Ku bin/store.rb


Console
-------

    % bin/console
