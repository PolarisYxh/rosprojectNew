# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from pan_tilt_msg/PanTiltCmd.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class PanTiltCmd(genpy.Message):
  _md5sum = "965a993146bc193a21484f0f1e9162eb"
  _type = "pan_tilt_msg/PanTiltCmd"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """## pan tilt control msg
## pan tilt yaw angle :deg
float32 yaw

## pan tilt pitch angle :deg
float32 pitch 

## pan tilt speed :deg/s
int16 speed
"""
  __slots__ = ['yaw','pitch','speed']
  _slot_types = ['float32','float32','int16']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       yaw,pitch,speed

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(PanTiltCmd, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.yaw is None:
        self.yaw = 0.
      if self.pitch is None:
        self.pitch = 0.
      if self.speed is None:
        self.speed = 0
    else:
      self.yaw = 0.
      self.pitch = 0.
      self.speed = 0

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_2fh().pack(_x.yaw, _x.pitch, _x.speed))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      _x = self
      start = end
      end += 10
      (_x.yaw, _x.pitch, _x.speed,) = _get_struct_2fh().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_2fh().pack(_x.yaw, _x.pitch, _x.speed))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      _x = self
      start = end
      end += 10
      (_x.yaw, _x.pitch, _x.speed,) = _get_struct_2fh().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_2fh = None
def _get_struct_2fh():
    global _struct_2fh
    if _struct_2fh is None:
        _struct_2fh = struct.Struct("<2fh")
    return _struct_2fh
