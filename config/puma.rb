# https://github.com/puma/puma/blob/master/examples/config.rb

# Bind the server to "url". "tcp://", "unix://" and "ssl://" are the only
# accepted protocols.
#
# The default is "tcp://0.0.0.0:9292".
#
bind "tcp://0.0.0.0:3000"


# https://www.speedshop.co/2017/10/12/appserver.html

=begin
                                  TL;DR

  1. Figure out how much memory 1 worker with 5 threads uses. Run just a few 
  workers on a single server under production load for at least 12 hours 
  without restarting. Use ps to get the memory usage of a typical worker.

  2. Choose a server size with memory equal to at least 3X that number. Most 
  Rails applications will use ~300-400MB of RAM per worker. So, most Rails apps 
  will need at least 1 GB per server. This gives us enough memory headroom to 
  run at least 3 processes per server. You can run a number of child processes 
  equal to (TOTAL_RAM / (RAM_PER_PROCESS * 1.2)).

  3. Check CPU core/hyperthread counts If your server has fewer hyperthreads 
  (vCPUs on AWS) than your memory can support, you can either choose a 
  container size with less memory or more CPU. Ideally, the number of child 
  processes you run should equal 1.25-1.5x the number of hyperthreads.

  4. Deploy and watch CPU and memory consumption. Tune child process count and 
  container size as appropriate to maximize usage.
=end


=begin
  All Ruby webapps should run at least 3 processes per server

  But what’s the maximum? That’s constrained by our memory and CPU resources.

  To get an accurate measurement of how much memory your Ruby application 
  processes are using, disable all process restarts (worker killers) and wait 
  12-24 hours to take a measurement with ps.
  Most Ruby applications will use between 200 and 400 MB per process, but some 
  can use as much as 1GB.
  Set your child process count to something like 
    (TOTAL_RAM / (RAM_PER_PROCESS * 1.2))

  Second, we don’t want to exceed the available CPU capacity of our server.
  Ideally, we don’t spend more than 5% of our total deployed time at 100% CPU 
  usage. How do you know? Just use your favorite server monitoring tool.
  In practice, most applications will probably settle at a process count that 
  is 1.25-1.5x the number of available hyperthreads.
=end
# How many worker processes to run.  Typically this is set to
# to the number of available cores.
#
# The default is "0".
#
# workers 3


=begin
  The speedup you can gain from additional parallelism depends on the portion 
  of your program’s execution which can be done in parallel. This is known as 
  Amdahl’s Law. In MRI/C Ruby, we can only parallelize waiting on IO (waiting 
  on a database result, for example). For most web applications, this is 
  probably 10-25% of their total time. You can check for your own application 
  by looking at the amount of time you spend “in the database” per request. 
  Unfortuantely, what Amdahl’s law reveals is that for programs that have small 
  parallel portions (less than 50%), there is little to no benefit past a 
  handful of threads.

  Unlike process count, with threads, it’s usually OK to just “set it and 
  forget it” to 5 threads per application server process.

  In MRI/C Ruby, threads can have a surprisingly large memory impact. This is 
  due to a host of complicated reasons. Be sure to check memory consumption 
  before and after adding threads to the application. Do not expect that each 
  thread will only consume an additional 8MB of stack space, they will often 
  increase total memory usage by far more than that.
=end
# Configure "min" to be the minimum number of threads to use to answer
# requests and "max" the maximum.
#
# The default is "0, 16".
#
# threads 5, 5


=begin
  All Unix-based operating systems implement copy-on-write memory behavior. 
  It’s pretty simple: when a process forks and creates a child, that child 
  process’ memory is shared, completely, with the parent process. All memory 
  reads from the child process will simply read from the parent’s memory. 
  However, modifying a memory location creates a copy, solely for the private 
  use of the child process. It’s extremely useful for reducing the memory 
  usage of forking webservers, since child processes should, in theory, be 
  able to share things like shared libraries and other “read-only” memory with 
  the parent, rather than creating their own copy.
=end
# Preload the application before starting the workers; this conflicts with
# phased restart feature. (off by default)
#
# preload_app!
#
# Code to run in a worker before it starts serving requests.
# This is called everytime a worker is to be started.
#
# on_worker_boot do
#   # Valid on Rails 4.1+ using the `config/database.yml` method of setting `pool` size
#   ActiveRecord::Base.establish_connection
# end


=begin
  The amount of memory available to our server is probably one of the most 
  important resources we can tune. On many providers, this number is 
  exceedingly low (~512MB).

  Because most Rails applications use ~300MB of RAM and I think everyone should 
  be running at least 3 processes per server, most Rails applications will need 
  a server with at least 1 GB of RAM.

  Our server’s CPU resources are another important lever we can tune. We need 
  to know how many CPU cores are available to us, and how many threads we can 
  execute at a single time (does this server support Hyper-Threading or not?).
  Your server should support at least 3 child processes. Even better would be 
  8 or more processes per server/container. Higher process counts per container 
  improves request routing and decreases latency.
=end
