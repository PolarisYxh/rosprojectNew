; Auto-generated. Do not edit!


(cl:in-package color_depth_msg-msg)


;//! \htmlinclude colordepth.msg.html

(cl:defclass <colordepth> (roslisp-msg-protocol:ros-message)
  ((color
    :reader color
    :initarg :color
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (depth
    :reader depth
    :initarg :depth
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image)))
)

(cl:defclass colordepth (<colordepth>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <colordepth>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'colordepth)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name color_depth_msg-msg:<colordepth> is deprecated: use color_depth_msg-msg:colordepth instead.")))

(cl:ensure-generic-function 'color-val :lambda-list '(m))
(cl:defmethod color-val ((m <colordepth>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader color_depth_msg-msg:color-val is deprecated.  Use color_depth_msg-msg:color instead.")
  (color m))

(cl:ensure-generic-function 'depth-val :lambda-list '(m))
(cl:defmethod depth-val ((m <colordepth>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader color_depth_msg-msg:depth-val is deprecated.  Use color_depth_msg-msg:depth instead.")
  (depth m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <colordepth>) ostream)
  "Serializes a message object of type '<colordepth>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'color) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'depth) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <colordepth>) istream)
  "Deserializes a message object of type '<colordepth>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'color) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'depth) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<colordepth>)))
  "Returns string type for a message object of type '<colordepth>"
  "color_depth_msg/colordepth")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'colordepth)))
  "Returns string type for a message object of type 'colordepth"
  "color_depth_msg/colordepth")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<colordepth>)))
  "Returns md5sum for a message object of type '<colordepth>"
  "6b5aeff90d2304214393960f2a5a3312")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'colordepth)))
  "Returns md5sum for a message object of type 'colordepth"
  "6b5aeff90d2304214393960f2a5a3312")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<colordepth>)))
  "Returns full string definition for message of type '<colordepth>"
  (cl:format cl:nil "sensor_msgs/Image  color~%sensor_msgs/Image  depth~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'colordepth)))
  "Returns full string definition for message of type 'colordepth"
  (cl:format cl:nil "sensor_msgs/Image  color~%sensor_msgs/Image  depth~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <colordepth>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'color))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'depth))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <colordepth>))
  "Converts a ROS message object to a list"
  (cl:list 'colordepth
    (cl:cons ':color (color msg))
    (cl:cons ':depth (depth msg))
))
