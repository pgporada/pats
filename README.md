# Overview: Phil's Automated Test Suite aka PATS
This is my version of an automated test suite written entirely in bash shell script. I had a stipulation that we couldn't make any outbound network calls to pull down [BATS](https://github.com/sstephenson/bats) so I decided to write my own. We no longer use this, but I think it's a good reference to anyone who's ever thought about writing tests for their Ansible/Salt/Chef/Puppet code.

The philosophy is that you write some configuration management code or a shell script and you run a test or suite of tests against it so that you don't have to manually verify that commands are doing what you believe they should be doing. This helps you to iterate faster and reduce the mean time between failures which allows you to get working and hopefully proper functioning code released faster. You can choose to put all your trust in the system configuring your systems, but what happens when you need to upgrade that system? I personally would choose to use a 3rd party system in addition to my configuration management to verify that the upgrade was successfull and no state changes broke during the upgrade process. Testing also allows you to pass your code off to another engineer who may not be well versed with the application in question. They can read the tests, written in simple bash, to learn how to interact with the application which helps to promote learning.

- - - -
# How it works

The PATS engine is `pats_engine.bash`. Each `test_whatever.bash` script should `source pats_engine.bash`. From there, all your custom testing logic is written to `test_whatever.bash`. You can either run this against remote nodes or deploy it onto a node itself. It's really up to you!

To run a test script, simply issue

    bash test_whatever.bash

You will then see output such as

    ok - Whatever is active
    ok - Whatever is running
    not ok - Whatever is accessible on port 9090

- - - -
# Music
[Mischief Brew - Lowly Carpenter](https://www.youtube.com/watch?v=swW4mJuLzWw)

- - - -
# License and Author Information
GPLv3
[Phil Porada](https://philporada.com) - 2017
