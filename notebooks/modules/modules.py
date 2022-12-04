#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
jupyter modules
"""
import turtle
from PIL import Image
import os
from IPython.display import Image as IImage
from IPython.display import display

os.environ.__setitem__('DISPLAY', ':0.0')
os.system('Xvfb :0 -screen 0 800x600x16  &')

def display_cat(cat, fileName = 'cat'):
    
    # save postscipt image 
    cat.getscreen().getcanvas().postscript(file = fileName + '.eps') 
    # use PIL to convert to PNG 
    img = Image.open(fileName + '.eps') 
    img.save(fileName + '.png', 'png')
    os.remove(fileName + '.eps')
    display(IImage(filename=fileName + '.png'))