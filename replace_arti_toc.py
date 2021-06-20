# -*- coding: utf-8 -*-
"""
    @file: replace_img.py
    @date: 2021-06-20 11:05 AM
"""

import os

fileDir = "/Users/blair/ghome/blog/source/_posts/"

file_path = []


def func():
    for root, dirs, files in os.walk(fileDir):
        for fileitem in files:
            file_path.append('{}/{}'.format(root, fileitem))


def replace_img(file):
    print(file)
    with open(file, "r") as f:
        file_data = ""

        for line in f:
            # toc: true
            if 'mathjax: true' not in line:
                file_data += line
                continue

        with open(file, "w") as f:
            f.write(file_data)


if __name__ == "__main__":
    func()
    for item in file_path:
        if ".md" not in item:
            continue
        replace_img(item)
