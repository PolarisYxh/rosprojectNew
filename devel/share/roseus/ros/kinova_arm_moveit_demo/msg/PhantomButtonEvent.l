;; Auto-generated. Do not edit!


(when (boundp 'kinova_arm_moveit_demo::PhantomButtonEvent)
  (if (not (find-package "KINOVA_ARM_MOVEIT_DEMO"))
    (make-package "KINOVA_ARM_MOVEIT_DEMO"))
  (shadow 'PhantomButtonEvent (find-package "KINOVA_ARM_MOVEIT_DEMO")))
(unless (find-package "KINOVA_ARM_MOVEIT_DEMO::PHANTOMBUTTONEVENT")
  (make-package "KINOVA_ARM_MOVEIT_DEMO::PHANTOMBUTTONEVENT"))

(in-package "ROS")
;;//! \htmlinclude PhantomButtonEvent.msg.html


(defclass kinova_arm_moveit_demo::PhantomButtonEvent
  :super ros::object
  :slots (_grey_button _white_button ))

(defmethod kinova_arm_moveit_demo::PhantomButtonEvent
  (:init
   (&key
    ((:grey_button __grey_button) 0)
    ((:white_button __white_button) 0)
    )
   (send-super :init)
   (setq _grey_button (round __grey_button))
   (setq _white_button (round __white_button))
   self)
  (:grey_button
   (&optional __grey_button)
   (if __grey_button (setq _grey_button __grey_button)) _grey_button)
  (:white_button
   (&optional __white_button)
   (if __white_button (setq _white_button __white_button)) _white_button)
  (:serialization-length
   ()
   (+
    ;; int32 _grey_button
    4
    ;; int32 _white_button
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _grey_button
       (write-long _grey_button s)
     ;; int32 _white_button
       (write-long _white_button s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _grey_button
     (setq _grey_button (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _white_button
     (setq _white_button (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get kinova_arm_moveit_demo::PhantomButtonEvent :md5sum-) "fb77877e6b639935c3360838062f05f0")
(setf (get kinova_arm_moveit_demo::PhantomButtonEvent :datatype-) "kinova_arm_moveit_demo/PhantomButtonEvent")
(setf (get kinova_arm_moveit_demo::PhantomButtonEvent :definition-)
      "int32 grey_button
int32 white_button

")



(provide :kinova_arm_moveit_demo/PhantomButtonEvent "fb77877e6b639935c3360838062f05f0")


