
(cl:in-package :asdf)

(defsystem "color_depth_msg-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :sensor_msgs-msg
)
  :components ((:file "_package")
    (:file "colordepth" :depends-on ("_package_colordepth"))
    (:file "_package_colordepth" :depends-on ("_package"))
  ))