#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/yxh/Documents/mars/src/kinova-ros-master/kinova_demo"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/yxh/Documents/mars/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/yxh/Documents/mars/install/lib/python2.7/dist-packages:/home/yxh/Documents/mars/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/yxh/Documents/mars/build" \
    "/usr/bin/python2" \
    "/home/yxh/Documents/mars/src/kinova-ros-master/kinova_demo/setup.py" \
     \
    build --build-base "/home/yxh/Documents/mars/build/kinova-ros-master/kinova_demo" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/yxh/Documents/mars/install" --install-scripts="/home/yxh/Documents/mars/install/bin"
