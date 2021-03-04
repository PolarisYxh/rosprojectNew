;; Auto-generated. Do not edit!


(when (boundp 'kinova_arm_moveit_demo::OmniFeedback)
  (if (not (find-package "KINOVA_ARM_MOVEIT_DEMO"))
    (make-package "KINOVA_ARM_MOVEIT_DEMO"))
  (shadow 'OmniFeedback (find-package "KINOVA_ARM_MOVEIT_DEMO")))
(unless (find-package "KINOVA_ARM_MOVEIT_DEMO::OMNIFEEDBACK")
  (make-package "KINOVA_ARM_MOVEIT_DEMO::OMNIFEEDBACK"))

(in-package "ROS")
;;//! \htmlinclude OmniFeedback.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass kinova_arm_moveit_demo::OmniFeedback
  :super ros::object
  :slots (_force _position _lock ))

(defmethod kinova_arm_moveit_demo::OmniFeedback
  (:init
   (&key
    ((:force __force) (instance geometry_msgs::Vector3 :init))
    ((:position __position) (instance geometry_msgs::Vector3 :init))
    ((:lock __lock) (let (r) (dotimes (i 0) (push nil r)) r))
    )
   (send-super :init)
   (setq _force __force)
   (setq _position __position)
   (setq _lock __lock)
   self)
  (:force
   (&rest __force)
   (if (keywordp (car __force))
       (send* _force __force)
     (progn
       (if __force (setq _force (car __force)))
       _force)))
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:lock
   (&optional __lock)
   (if __lock (setq _lock __lock)) _lock)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Vector3 _force
    (send _force :serialization-length)
    ;; geometry_msgs/Vector3 _position
    (send _position :serialization-length)
    ;; bool[] _lock
    (* 1    (length _lock)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Vector3 _force
       (send _force :serialize s)
     ;; geometry_msgs/Vector3 _position
       (send _position :serialize s)
     ;; bool[] _lock
     (write-long (length _lock) s)
     (dotimes (i (length _lock))
       (if (elt _lock i) (write-byte -1 s) (write-byte 0 s))
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Vector3 _force
     (send _force :deserialize buf ptr-) (incf ptr- (send _force :serialization-length))
   ;; geometry_msgs/Vector3 _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;; bool[] _lock
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lock (make-list n))
     (dotimes (i n)
     (setf (elt _lock i) (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
     ))
   ;;
   self)
  )

(setf (get kinova_arm_moveit_demo::OmniFeedback :md5sum-) "94755b031db27fe99c2c235c0da9b072")
(setf (get kinova_arm_moveit_demo::OmniFeedback :datatype-) "kinova_arm_moveit_demo/OmniFeedback")
(setf (get kinova_arm_moveit_demo::OmniFeedback :definition-)
      "# This is the force as estimated from the applied torques as well as the current
# end effector position of the robot arm                           
geometry_msgs/Vector3  force                                                                  
geometry_msgs/Vector3  position 
bool[] lock 
================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :kinova_arm_moveit_demo/OmniFeedback "94755b031db27fe99c2c235c0da9b072")


