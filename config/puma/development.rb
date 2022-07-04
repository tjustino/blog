# frozen_string_literal: true

# https://github.com/puma/puma/blob/master/examples/config.rb

# Bind the server to "url". "tcp://", "unix://" and "ssl://" are the only
# accepted protocols.
#
# The default is "tcp://0.0.0.0:9292".
#
bind "tcp://0.0.0.0:3000"

# https://www.speedshop.co/2017/10/12/appserver.html

#                                 TL;DR
#
# 1. Figure out how much memory 1 worker with 5 threads uses. Run just a few
# workers on a single server under production load for at least 12 hours
# without restarting. Use ps to get the memory usage of a typical worker.
#
# 2. Choose a server size with memory equal to at least 3X that number. Most
# Rails applications will use ~300-400MB of RAM per worker. So, most Rails apps
# will need at least 1 GB per server. This gives us enough memory headroom to
# run at least 3 processes per server. You can run a number of child processes
# equal to (TOTAL_RAM / (RAM_PER_PROCESS * 1.2)).
#
# 3. Check CPU core/hyperthread counts If your server has fewer hyperthreads
# (vCPUs on AWS) than your memory can support, you can either choose a
# container size with less memory or more CPU. Ideally, the number of child
# processes you run should equal 1.25-1.5x the number of hyperthreads.
#
# 4. Deploy and watch CPU and memory consumption. Tune child process count and
# container size as appropriate to maximize usage.
#

# How many worker processes to run.  Typically this is set to
# to the number of available cores.
#
# The default is "0".
#
# workers 3

# Configure "min" to be the minimum number of threads to use to answer
# requests and "max" the maximum.
#
# The default is "0, 16".
#
# threads 5, 5

# Preload the application before starting the workers; this conflicts with
# phased restart feature. (off by default)
#
# preload_app!
