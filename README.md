First attempt at writing a Robot Framework automation script.

Setup:
Will require node.js installed on the workstation to run Playwright tests.

Usage:
robot --outputdir results --listener FailureLogUploaderListener.py boost_shop_iphone.robot

Listener must be specified in the command line to ensure it gets invoked. This was implemented to capture the latest version of the log file. Previously when the upload happended in the teardown of the test, it was capturing the log file from the previous test run.
Note: * only works for a single test case at a time. Trying to run multiple test cases in a single execution will result in the log file from the last test case being uploaded - as the log file is only written when the entire test suite is complete.

Note: instance-id is the test case number and needs to be extract from the URL when looking the test instance in PY, ie.
https://prod.practitest.com/p/<project id>/sets/<test set id>>/instances/<instance id>/edit
It will be a large decimal number, e.g. 104962065

