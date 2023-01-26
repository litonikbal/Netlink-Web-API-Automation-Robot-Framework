====================================================
Web testing with Robot Framework and SeleniumLibrary
====================================================

`Robot Framework`_ is a generic open source test automation framework and
SeleniumLibrary_ is one of the many test libraries that can be used with
it. In addition to showing how they can be used together for web testing,
this demo introduces the basic Robot Framework test data syntax, how tests
are executed, and how logs and reports look like.


Test cases
==========

Test case files as well as a resource file used by them are located in
the ``login_test`` directory. Click file names below to see the latest versions
online.


`invalid_login.robot`_
    A test suite containing tests related to invalid login.

    These tests are data-driven by their nature. They use a single
    keyword, specified with the ``Test Template`` setting, that is called
    with different arguments to cover different scenarios.

    This suite also demonstrates using setups and teardowns in
    different levels.

`gherkin_login.robot`_
    A test suite with a single Gherkin style test.

    This test is functionally identical to the example in the
    `valid_login.robot`_ file.

`resource.robot`_
    A resource file with reusable keywords and variables.

    The system specific keywords created here form our own
    domain specific language. They utilize keywords provided
    by the imported SeleniumLibrary_.

See `Robot Framework User Guide`_ for more details about the test data syntax.

Generated results
=================

After `running tests`_ you will get report and log in HTML format. Example
files are also visible online in case you are not interested in running
the demo yourself:

- `report.html`_
- `log.html`_

Running demo
============

Preconditions
-------------

A precondition for running the tests is having `Robot Framework`_ and
SeleniumLibrary_ installed, and they in turn require
Python_. Robot Framework `installation instructions`__ cover both
Robot and Python installations, and SeleniumLibrary has its own
`installation instructions`__.

In practice it is easiest to install Robot Framework and
SeleniumLibrary along with its dependencies using `pip`_ package
manager. Once you have pip installed, all you need to do is running
these commands::

please refer requirements.txt for installations.


Running tests
-------------

The `test cases`_ are located in the ``login_tests`` directory. They can be
executed using the ``robot`` command::

    robot login_tests

.. note:: If you are using Robot Framework 2.9 or earlier, you need to
          use the ``pybot`` command instead.

You can also run an individual test case file and use various command line
options supported by Robot Framework::

	open command prompt (cmd)
	navigate to C:\Users\robot\Downloads\WebDemo-POC
	
RUN	
	
    robot login_tests/fin_message_template.robot    - this is to run specific test on firefox.

    robot login_tests                               -  all tests

    robot --test InvalidUserName --loglevel DEBUG login_tests

Run ``robot --help`` for more information about the command line usage and see
`Robot Framework User Guide`_ for more details about test execution in general.

Using different browsers
------------------------

The browser that is used is controlled by ``${BROWSER}`` variable defined in
`resource.robot`_ resource file. Firefox browser is used by default, but that
can be easily overridden from the command line::

    robot --variable BROWSER:Chrome login_tests

Consult SeleniumLibrary_ documentation about supported browsers.

.. _Robot Framework: http://robotframework.org
.. _SeleniumLibrary: https://github.com/robotframework/SeleniumLibrary
.. _Python: http://python.org
.. _pip: http://pip-installer.org


Using Allure Reporting
------------------------
To run test suite: robot --listener allure_robotframework ./login_tests 

To generate Allure Report: allure serve ./output/allure