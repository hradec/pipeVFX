# Backwards-compatibility with the old dbus_bindings.

from warnings import warn as _warn

_dbus_bindings_warning = DeprecationWarning("""\
The dbus_bindings module is not public API and will go away soon.

Most uses of dbus_bindings are applications catching the exception
dbus.dbus_bindings.DBusException. You should use dbus.DBusException
instead (this is compatible with all dbus-python versions since 0.40.2).

If you need additional public API, please contact the maintainers via
<dbus@lists.freedesktop.org>.
""")

_warn(_dbus_bindings_warning, DeprecationWarning, stacklevel=2)

# Exceptions
from dbus.exceptions import DBusException
class ConnectionError(Exception): pass

# Types
from dbus.types import *

# Messages
from _dbus_bindings import Message, SignalMessage as Signal,\
                           MethodCallMessage as MethodCall,\
                           MethodReturnMessage as MethodReturn,\
                           ErrorMessage as Error
# MessageIter has gone away, thankfully

# Connection
from _dbus_bindings import Connection

from dbus import Bus
bus_request_name = Bus.request_name
bus_release_name = Bus.release_name
