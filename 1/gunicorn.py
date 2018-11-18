# Warning: as currently written, the server must be run in single threaded
# mode for consistent behavior. This is due to the fact that data is process
# local, and there is no multithreading support.
workers = 1
threads = 1
