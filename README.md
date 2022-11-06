# simple-bmp-roku
Generate .bmp images from lists of RGB pixels on roku
Designed to support fake-blurhash, but perhaps useful to you as well.

With an roList of arrays [r,g,b] read top-to-bottom and left-to-right as pixels
'''
ba = simplebmp_bytearray(width, height, pixels)
ba.WriteFile("filename")
'''
