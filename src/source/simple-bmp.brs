'' Functions rdRightShift and rdINTtoHEX are borrowed from librokudev and are covered
'' by the license at https://github.com/sumitk/librokudev/blob/master/LICENSE

function _rdRightShift(num as integer, count = 1 as integer) as integer
  mult = 2 ^ count
  summand = 1
  total = 0
  for i = count to 31
    if num and summand * mult
      total = total + summand
    end if
    summand = summand * 2
  end for
  return total
end function

function _rdINTtoHEX(num as integer) as object
  ba = CreateObject("roByteArray")
  ba.setresize(4, false)
  ba[0] = rdRightShift(num, 24)
  ba[1] = rdRightShift(num, 16)
  ba[2] = rdRightShift(num, 8)
  ba[3] = num ' truncates
  return ba.toHexString().Right(2)
end function

function bytearray(width as integer, height as integer, pixels) as roByteArray 'pixels should be an roList of [r.g.b] arrays read top to bottom and left to right
  pad = width mod 4
  if pad <> 0
    pad = 4-pad
  end if
  bmp = "424D4C000000000000001A0000000C000000"
  bmp = bmp + _rdINTtoHEX(width) + "00" + _rdINTtoHEX(height) + "0001001800"
  for r = 1 to height
    row = ""
    for c = 1 to width
      pixel = pixels.RemoveTail()
      row = _rdINTtoHEX(pixel[2]) + _rdINTtoHEX(pixel[1]) + _rdINTtoHEX(pixel[0]) + row
    end for
    if pad <> 0
      for z = 1 to pad
        row=row+"00"
    end if
    bmp = bmp + row
  end for
  bmp = bmp + "0000"
  ba = CreateObject("roByteArray")
  ba.fromhexstring(bmp)
  return ba
end function