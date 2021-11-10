{
  "advertise_addr" : "{{ GetInterfaceIP \"eth0\" }}",
  "bind_addr": "{{ GetInterfaceIP \"eth0\" }}",
  "client_addr": "0.0.0.0",
  "data_dir": "/consul/data",
  "node_name": "consul-server",
  "datacenter": "swarm",
  "leave_on_terminate" : true,
  "retry_join" : [
    "consul.server"
  ],
  "server_name" : "consul-server",
  "skip_leave_on_interrupt" : true,
  "bootstrap_expect": 3,
  "server" : true,
  "ui" : true,
  "autopilot": {
    "cleanup_dead_servers": true
  },
  "disable_update_check": true,
  "log_level": "warn"
  }
