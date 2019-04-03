import cv2
import sys
import logging as log
import datetime as dt
from time import sleep
import base64
from PIL import Image
import io
import numpy as np

cascPath = "haarcascade_frontalface_default.xml"
faceCascade = cv2.CascadeClassifier(cascPath)
log.basicConfig(filename='webcam.log',level=log.INFO)

video_capture = cv2.VideoCapture(0)
anterior = 0

# while True:
if not video_capture.isOpened():
    print('Unable to load camera.')
    sleep(5)
    pass

    # Capture frame-by-frame
ret, frame = video_capture.read()

gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

faces = faceCascade.detectMultiScale(
    gray,
    scaleFactor=1.1,
    minNeighbors=5,
    minSize=(30, 30)
)

    # Draw a rectangle around the faces
for (x, y, w, h) in faces:
    cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)

if anterior != len(faces):
    anterior = len(faces)
    log.info("faces: "+str(len(faces))+" at "+str(dt.datetime.now()))


    # Display the resulting frame
    # cv2.imshow('Video', frame)
# c = base64.b64encode(frame)
# print(frame)
encoded_string = base64.b64encode(frame)
# decode frame
decoded_string = base64.b64decode(encoded_string)
decoded_img = np.fromstring(decoded_string, dtype=np.uint8)
decoded_img = decoded_img.reshape(frame.shape)
# show decoded frame
cv2.imshow("decoded", decoded_img)

    # Display the resulting frame
    # cv2.imshow('Video', frame)

# When everything is done, release the capture
video_capture.release()
cv2.destroyAllWindows()