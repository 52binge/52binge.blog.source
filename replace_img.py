# -*- coding: utf-8 -*-
"""
    @file: replace_img.py
    @date: 2021-06-20 11:05 AM
"""

import os, sys
import importlib
importlib.reload(sys)

fileDir = "/Users/blair/ghome/blog/source/_posts/tools"

file_path = []


def func():
    for root, dirs, files in os.walk(fileDir):
        for fileitem in files:
            file_path.append('{}/{}'.format(root, fileitem))


def replace_img(file):
    print(file)
    file_data = ""
    with open(file, "r", encoding='utf-8') as f:
        for line in f:
            if '<img' not in line or '/>' not in line:
                file_data += line
                continue

            print("OLD_LINE: " + line)

            old1 = "<img src="
            new1 = "{% image "

            old2 = '" width'
            new2 = '", width'

            default_flag3 = '" />'
            if '"/>' in line:
                default_flag3 = '"/>'

            old3 = '" alt' if "alt" in line else default_flag3
            new3 = 'px", alt' if "alt" in line else 'px" %}'

            old4 = '/>'
            new4 = '%}'
            line = line.replace(old1, new1).replace(old2, new2).replace(old3, new3).replace(old4, new4)

            print("NEW_LINE: " + line)

            file_data += line

    with open(file, "w", encoding='utf-8') as f:
        f.write(file_data)


if __name__ == "__main__":
    func()
    for item in file_path:
        if ".md" not in item:
            continue
        replace_img(item)
