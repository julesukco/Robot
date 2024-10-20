First attempt at writing a Robot Framework automation script.

Setup:
Will require node.js installed on the workstation to run Playwright tests.

Usage:
robot --outputdir results --listener FailureLogUploaderListener.py boost_shop_iphone.robot

Listener must be specified in the command line to ensure it gets invoked. This was implemented to capture the latest version of the log file. Previously when the upload happended in the teardown of the test, it was capturing the log file from the previous test run.