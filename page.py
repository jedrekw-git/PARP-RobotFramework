# -*- coding: utf-8 -*-
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.ui import WebDriverWait
import rstr

class page(object):
    def __init__(self, driver=None, title=None, url=None):
        self._driver = driver
        self._title = title
        self._url = url

    def get_driver(self):
        return self._driver

    def wait_for_visibility(self, locator, info="no error", timeout=10):
        return WebDriverWait(self.get_driver(), timeout).until(
            expected_conditions.visibility_of_element_located(locator), info)

    def find_element(self, locator):
        return self.get_driver().find_element(*locator)

    def clear_field(self, locator):
        self.find_element(locator).clear()

    def send_keys(self, value_to_send, locator, info="field was not visible"):
        self.wait_for_visibility(locator, info)
        self.find_element(locator).send_keys(value_to_send)
        return self

    def clear_field_and_send_keys(self, value_to_send, locator, info="field was not visible"):
        self.clear_field(locator)
        self.send_keys(value_to_send, locator, info)

    def get_random_string(length):
        return rstr.rstr("abcdefghijklmnoprstuwxyz", length)

    def send_to_field_random_value_of_length(self, locator, leng, info="field was not visible"):
        self.clear_field(locator)
        value = rstr.rstr("abcdefghijklmnoprstuwxyz", leng)
        self.send_keys(value, locator, info)

    def my_click(self, locator, info="click on button error", timeout=5):
        element = self.wait_for_visibility(locator, info, timeout)
        element.click()
