import numpy as np
import cv2
import os
import shutil

video_file = 'test_short.mp4'
folder_output = os.path.join(os.getcwd(), 'frames')

cap = cv2.VideoCapture(video_file)

# Check and create folder
if not os.path.exists(folder_output):
    os.makedirs(folder_output)
else:
    shutil.rmtree(folder_output)
    os.makedirs(folder_output)

i = 0
while cap.isOpened():
    ret, frame = cap.read()

    if ret:
        # Save frames
        frame_filename = os.path.join(folder_output, '%d.jpg' % i)
        print('Saving: ' + frame_filename)
        cv2.imwrite(frame_filename, frame)
        i += 1

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
    else:
        break

cap.release()
cv2.destroyAllWindows()
