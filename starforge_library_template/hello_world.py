"""
Hello World module for the Starforge library template.

This module provides a simple HelloWorld class that demonstrates
basic functionality for the library template.
"""


class HelloWorld:
    """
    A simple class that provides greeting functionality.
    
    This class serves as a minimal example for the library template.
    """

    def greet(self) -> str:
        """
        Return a greeting message.
        
        Returns:
            str: A simple greeting message.
        """
        return 'Hello'

    def greet_with_name(self, name: str) -> str:
        """
        Return a personalized greeting message.
        
        Args:
            name (str): The name to include in the greeting.
            
        Returns:
            str: A personalized greeting message.
        """
        return f'Hello, {name}!'
