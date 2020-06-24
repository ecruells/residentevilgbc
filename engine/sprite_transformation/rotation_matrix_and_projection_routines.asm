
; Calculate an entity sprite vertex rotation matrix and projection
;
; First, we translate the sprite vertex about the camera position vertex
;
; x = x + camX
; y = y + camY
; z = z + camZ
;
; Then, we apply a rotation matrix to each axis, but to offload some heavy calculations, 
; an optimized rotation matrix is precalculated the following way:
;
; The camera is only rotated about X and Y axis, so a composite rotation matrix is built by
; combining both the x-axis (pitch) and y-axis (yaw) using their corresponding rotations matrices
;
; Rotate about x(a)     Rotate about y(b)
; | 1    0      0   |   | cosB   0  -sinB |
; | 0   cosA  -sinA | * |  0     1    0   |
; | 0   sinA   cosA |   | sinB   0   cosB |
;
; the resulting rotation matrix is multiplied by the vertex vector
;
; rx = |   cosB       0      -sinB    |   | x |
; rz = |-sinA*sinB   cosA  -sinA*cosB | * | y |
; ry = | cosA*sinB   sinA   cosA*cosB |   | z |
;
; rx = |          x*cosB - z*sinB           |
; rz = |-x*sinA*sinB + y*cosA - z*sinA*cosB |
; ry = | x*cosA*sinB + y*sinA + z*cosA*cosB |
;
; rearrange and factorize to get an optimized matrix
;
; rx = |          x*cosB - z*sinB           |
; rz = | y*cosA - x*sinA*sinB - z*sinA*cosB |
; ry = | y*sinA + x*cosA*sinB + z*cosA*cosB |
; 
; rx = |         x*cosB - z*sinB           |
; rz = | y*cosA - (x*sinB + z*cosB) * sinA |
; ry = | y*sinA + (x*sinB + z*cosB) * cosA |
;
; This way, we save some precious cpu cycles by calculating "(x*sinB + z*cosB)" once
;
; By each trig multiplication, we must right shift the result to fix the scale, because
; we are dealing with fixed point calculations (sine values in LUT are left shifted 6 bits)
;
; rx = ( x*cosB - z*sinB ) >> 4
; rz = ( y*cosA - ( ( x*sinB + z*cosB ) >> 6 ) * sinA ) >> 6
; ry = ( y*sinA + ( ( x*sinB + z*cosB ) >> 6 ) * cosA ) >> 4
;
; Translate XY points by camera XY translation and right shift 2 bits to fully scale back
;
; x = (rx + camTx) >> 2    
; y = (ry + camTy) >> 2
;
; Translate Z point, multiply by ZScaleFactor and divide by a zoom factor of 128 (a bigger zoom factor 
; means a closer camera)

; z = ((rz + camTz) * zScaleFactor) / 128
;
; Finally, project XY points from 3D to 2D. 
; Multiply by their respective scale factors (the greater the factor, the greater will be each point distance), 
; divide by Z (camera distance) and add viewport offset
;
; px = (x * xScaleFactor) / z + 88
; py = (y * yScaleFactor) / z + 80
;
;
calcRotationMatrixAndProjection:: ;00:0EC5
; TRANSLATE SPRITE VERTEX ABOUT CAMERA POSITION VERTEX
;
; x = spriteX + cameraX
    ld a, [wCameraPositionX]
    ld e, a
    ld a, [wCameraPositionX+1]
    ld d, a
    ld a, [wSpriteProjectedX]
    ld l, a
    ld a, [wSpriteProjectedX+1]
    ld h, a
    add hl, de ; spriteX + cameraX
    ld a, l
    ld [wSpriteProjectedX], a
    ld [wUnusedSpritePositionX], a
    ld a, h
    ld [wSpriteProjectedX+1], a
    ld [wUnusedSpritePositionX+1], a

; y = spriteY + cameraY
    ld a, [wCameraPositionY]
    ld e, a
    ld a, [wCameraPositionY+1]
    ld d, a
    ld a, [wSpriteProjectedY]
    ld l, a
    ld a, [wSpriteProjectedY+1]
    ld h, a
    add hl, de ; spriteY + cameraY
    ld e, l
    ld d, h
    call reverseDESign
    ld a, e
    ld [wSpriteProjectedY], a
    ld [wUnusedSpritePositionY], a
    ld a, d
    ld [wSpriteProjectedY+1], a
    ld [wUnusedSpritePositionY+1], a

; z = spriteZ + cameraZ
    ld a, [wCameraPositionZ]
    ld e, a
    ld a, [wCameraPositionZ+1]
    ld d, a
    ld a, [wSpriteProjectedZ]
    ld l, a
    ld a, [wSpriteProjectedZ+1]
    ld h, a
    add hl, de ; spriteZ + cameraZ
    ld a, l
    ld [wSpriteProjectedZ], a
    ld [wUnusedSpritePositionZ], a
    ld a, h
    ld [wSpriteProjectedZ+1], a
    ld [wUnusedSpritePositionZ+1], a

;
; ROTATE SPRITE VERTICES
;
; ROTATE X AXIS
;
; rx = ( x * cos(camYaw) ) - ( z * sin(camYaw) ) / 16
    ld a, [wSpriteProjectedX]
    ld e, a
    ld a, [wSpriteProjectedX+1]
    ld d, a
    ld a, [wCameraYawCos]
    ld l, a
    ld h, 0
    call wordAndByteMultiply ; x * cos(camYaw)
    ld a, e
    ld [wPrevMultProduct], a
    ld a, d
    ld [wPrevMultProduct+1], a
    ld a, [wSpriteProjectedZ]
    ld e, a
    ld a, [wSpriteProjectedZ+1]
    ld d, a
    ld a, [wCameraYawSin]
    ld l, a
    ld h, 0
    call wordAndByteMultiply ; z * sin(camYaw)
; ( x * cos(camYaw) ) - ( z * sin(camYaw) ) / 16
    call subMultiplyProducts
    call div16Word 
    ld a, e
    ld [wSpriteRotatedX], a
    ld a, d
    ld [wSpriteRotatedX+1], a


; store sprite y copy for some reason
    ld a, [wSpriteProjectedY]
    ld [wSpritePositionTY2], a
    ld a, [wSpriteProjectedY+1]
    ld [wSpritePositionTY2+1], a

; sxcz = (x * sin(camYaw) + z * con(camYaw)) / 64
    ld a, [wSpriteProjectedX]
    ld e, a
    ld a, [wSpriteProjectedX+1]
    ld d, a
    ld a, [wCameraYawSin]
    ld l, a
    ld h, 0
    call wordAndByteMultiply ; x * sin(camYaw)
    ld a, e
    ld [wPrevMultProduct], a
    ld a, d
    ld [wPrevMultProduct+1], a
    ld a, [wSpriteProjectedZ]
    ld e, a
    ld a, [wSpriteProjectedZ+1]
    ld d, a
    ld a, [wCameraYawCos]
    ld l, a
    ld h, 0
    call wordAndByteMultiply ;  z * con(camYaw)
    call addMultiplyProducts
    call div64Word
    ld a, e
    ld [wRotatedSXCZ], a
    ld a, d
    ld [wRotatedSXCZ+1], a

; x = rx = (( x * cos(camYaw) ) - ( z * sin(camYaw) ) / 16)
    ld a, [wSpriteRotatedX]
    ld [wSpriteProjectedX], a
    ld a, [wSpriteRotatedX+1]
    ld [wSpriteProjectedX+1], a

;
; ROTATE Z AXIS
;
; rz = ( y * sin(camPitch  - sxcz * sin(camPitch) ) / 64
    ld a, [wSpritePositionTY2]
    ld e, a
    ld a, [wSpritePositionTY2+1]
    ld d, a
    ld a, [wCameraPitchCos]
    ld l, a
    ld h, 0
    call wordAndByteMultiply ; y * sin(camPitch)
    ld a, e
    ld [wPrevMultProduct], a
    ld a, d
    ld [wPrevMultProduct+1], a
    ld a, [wRotatedSXCZ]
    ld e, a
    ld a, [wRotatedSXCZ+1]
    ld d, a
    ld a, [wCameraPitchSine]
    ld l, a
    ld h, 0
; sxcz * sin(camPitch) / 64
    call wordAndByteMultiply 
    call subMultiplyProducts
    call div64Word
    ld a, e
    ld [wSpriteProjectedZ], a
    ld a, d
    ld [wSpriteProjectedZ+1], a

;
; ROTATE Y AXIS
;
; ry = (y * sin(camPitch) + sxcz * cos(camPitch)) / 16
    ld a, [wSpritePositionTY2]
    ld e, a
    ld a, [wSpritePositionTY2+1]
    ld d, a
    ld a, [wCameraPitchSine]
    ld l, a
    ld h, 0
    call wordAndByteMultiply ; y * sin(camPitch)
    ld a, e
    ld [wPrevMultProduct], a
    ld a, d
    ld [wPrevMultProduct+1], a
    ld a, [wRotatedSXCZ]
    ld e, a
    ld a, [wRotatedSXCZ+1]
    ld d, a
    ld a, [wCameraPitchCos]
    ld l, a
    ld h, 0
    call wordAndByteMultiply ; sxcz * cos(camPitch)
    call addMultiplyProducts
    call div16Word
    ld a, e
    ld [wSpriteProjectedY], a
    ld a, d
    ld [wSpriteProjectedY+1], a

; TRANSLATE ROTATED X BY CAM TX
;
; x = (rx + camTx)
    ld a, [wCameraPositionTX]
    ld l, a
    ld a, [wCameraPositionTX+1]
    ld h, a
    ld a, [wSpriteProjectedX]
    ld e, a
    ld a, [wSpriteProjectedX+1]
    ld d, a
    add hl, de
    ld a, l
    ld [wSpriteProjectedX], a
    ld a, h
    ld [wSpriteProjectedX+1], a

; TRANSLATE ROTATED Y BY CAM TY
;
; y = ry + camTy
    ld a, [wCameraPositionTY]
    ld l, a
    ld a, [wCameraPositionTY+1]
    ld h, a
    ld a, [wSpriteProjectedY]
    ld e, a
    ld a, [wSpriteProjectedY+1]
    ld d, a
    add hl, de
    ld a, l
    ld [wSpriteProjectedY], a
    ld a, h
    ld [wSpriteProjectedY+1], a

; CALCULATE CAMERA DISTANCE
;
; TRANSLATE ROTATED  BY CAM TZ
; z = rz + camTz
    ld a, [wCameraPositionTZ]
    ld l, a
    ld a, [wCameraPositionTZ+1]
    ld h, a
    ld a, [wSpriteProjectedZ]
    ld e, a
    ld a, [wSpriteProjectedZ+1]
    ld d, a
    add hl, de
    ld a, l
    ld [wSpriteProjectedZ], a
    ld a, h
    ld [wSpriteProjectedZ+1], a

; finish the trig multiplication scale fix by dividing by 4 (right shift by 2)
; x = x / 4
    ld hl, wSpriteProjectedX
    call div4WordVar

; y = y / 4
    ld hl, wSpriteProjectedY
    call div4WordVar

; apply scale factors
;
; z = (z * zScalefactor) / 128
    ld a, [wSpriteProjectedZ]
    ld e, a
    ld a, [wSpriteProjectedZ+1]
    ld d, a
    ld a, [wZScaleFactor]
    ld l, a
    ld a, [wZScaleFactor+1]
    ld h, a
    call wordAndByteMultiply
    call div128Word ; divide by zoom factor (128)
    ld a, e
    ld [wSpriteProjectedZ], a
    ld a, d
    ld [wSpriteProjectedZ+1], a

; PROJECT X POINT
;
; px = ( (x * xScalefactor) / z ) + 88
    ld a, [wSpriteProjectedX]
    ld e, a
    ld a, [wSpriteProjectedX+1]
    ld d, a
    ld a, [wXScaleFactor]
    ld l, a
    ld a, [wXScaleFactor+1]
    ld h, a
    call wordAndByteMultiply
    ld a, [wSpriteProjectedZ]
    ld c, a
    ld a, [wSpriteProjectedZ+1]
    ld b, a
    call wordDivision
    ld a, e
    add a, 88
    ld [wSpriteProjectedX], a
    ld a, d
    adc a, 0
    ld [wSpriteProjectedX+1], a

; PROJECT Y POINT
;
; py = ( (y * yScaleFactor) / z ) + 80
    ld a, [wSpriteProjectedY]
    ld e, a
    ld a, [wSpriteProjectedY+1]
    ld d, a
    ld a, [wYScaleFactor]
    ld l, a
    ld a, [wYScaleFactor+1]
    ld h, a
    call wordAndByteMultiply
    ld a, [wSpriteProjectedZ]
    ld c, a
    ld a, [wSpriteProjectedZ+1]
    ld b, a
    call wordDivision
    ld a, e
    add a, 80
    ld [wSpriteProjectedY], a
    ld a, d
    adc a, 0
    ld [wSpriteProjectedY+1], a
    ret


