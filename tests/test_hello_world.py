from unittest import TestCase

from src.starforge_library_template.hello_world import HelloWorld


class TestHelloWorld(TestCase):

    def test_greeting_response(self):
        hello_world = HelloWorld()

        result = hello_world.greet()

        self.assertEqual('Hello', result)
