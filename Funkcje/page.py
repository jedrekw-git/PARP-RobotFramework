# -*- coding: utf-8 -*-
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.ui import WebDriverWait
import rstr
from ExtendedSelenium2Library import ExtendedSelenium2Library
from random import randint
import uuid
import datetime

class page(ExtendedSelenium2Library):
    # def __init__(self, driver=None, title=None, url=None):
    #     self._driver = driver
    #     self._title = title
    #     self._url = url

    def get_driver(self):
        return self._current_browser()

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

    def get_random_string(self, length=8):
        return rstr.rstr("abcdefghijklmnoprstuwxyz", length)

    def get_random_string_big_letters(self, length=8):
        return rstr.rstr("ABCDEFGHIJKLMNOPRSTUWXYZ", length)

    def get_random_password(self):
        return str(self.get_random_integer(2)+self.get_random_string(4)+self.get_random_string_big_letters(4)+"$")

    def get_random_password_1_char_long(self):
        return str(self.get_random_integer(1))

    def get_random_integer(self, length=6):
        range_start = 10**(length-1)
        range_end = (10**length)-1
        return str(randint(range_start, range_end))

    def get_random_pesel(self):
        a = randint(0, 9)
        b = randint(0, 9)
        c = 0
        d = randint(0, 9)
        e = 0
        f = randint(0, 9)
        g = randint(0, 9)
        h = randint(0, 9)
        i = randint(0, 9)
        j = randint(0, 9)
        k = (9*a+7*b+1*d+7*f+3*g+1*h+9*i+7*j) % 10
        return str(a)+str(b)+"0"+str(d)+"0"+str(f)+str(g)+str(h)+str(i)+str(j)+str(k)

    def get_random_nip(self):
        a = randint(0, 9)
        b = randint(0, 9)
        c = randint(0, 9)
        d = randint(0, 9)
        e = randint(0, 9)
        f = randint(0, 9)
        g = randint(0, 9)
        h = randint(0, 9)
        i = randint(0, 9)
        j = (6*a+5*b+7*c+2*d+3*e+4*f+5*g+6*h+7*i) % 11
        return str(a)+str(b)+str(c)+str(d)+str(e)+str(f)+str(g)+str(h)+str(i)+str(j)

    def get_random_regon(self):
        a = randint(0, 9)
        b = randint(0, 9)
        c = randint(0, 9)
        d = randint(0, 9)
        e = randint(0, 9)
        f = randint(0, 9)
        g = randint(0, 9)
        h = randint(0, 9)
        j = (8*a+9*b+2*c+3*d+4*e+5*f+6*g+7*h) % 11
        if j == 10:
            j = 0
        return str(a)+str(b)+str(c)+str(d)+str(e)+str(f)+str(g)+str(h)+str(j)

    def get_random_uuid(self, length=5):
        return str(uuid.uuid1())[:length]

    def get_random_email(self):
        return str(self.get_random_uuid(9) + "@wp.pl")

    def get_todays_date(self):
        _today = datetime.date.today()
        return _today.strftime('%Y-%m-%d')

    def send_to_field_random_value_of_length(self, locator, leng, info="field was not visible"):
        self.clear_field(locator)
        value = rstr.rstr("abcdefghijklmnoprstuwxyz", leng)
        self.send_keys(value, locator, info)

    def my_click(self, locator, info="click on button error", timeout=5):
        # element = self.wait_for_visibility(locator, info, timeout)
        # self.get_driver()._element_find(locator).click()
        self.get_driver().execute_script("arguments[0].click();", self.find_element((locator)))
        # element.click()
        # BuiltIn().run_keyword(locator, info, timeout)
