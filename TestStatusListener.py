from robot.api import logger

class TestStatusListener:
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self):
        self.test_status = None

    def end_test(self, name, attributes):
        self.test_status = attributes['status']
        logger.info(f"Test Case '{name}' ended with status: {self.test_status}")
