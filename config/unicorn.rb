worker_processes 2
working_directory "/home/anime/presentation/current"

listen "/var/run/unicorn/unicorn_presentation.sock"
pid "/var/run/unicorn/unicorn_presentation.pid"

preload_app true