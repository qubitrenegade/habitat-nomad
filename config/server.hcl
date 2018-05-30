
data_dir = "{{cfg.server.data_dir}}"

advertise {
  # Defaults to the first private IP address.
  http = "{{sys.ip}}"
  rpc  = "{{sys.ip}}"
  serf = "{{sys.ip}}" # non-default ports may be specified
}

server {
  enabled           = true
  bootstrap_expect  = {{cfg.server.bootstrap_expect}}
}

{{#if cfg.consul}}
consul {
  address               = "{{cfg.consul.address}}"
  server_service_name   = "{{cfg.consul.server_service_name}}"
  client_service_name   = "{{cfg.consul.client_service_name}}"
  auto_advertise        = {{cfg.consul.auto_advertise}}
  server_auto_join      = {{cfg.consul.server_auto_join}}
  client_auto_join      = {{cfg.consul.client_auto_join}}
}
{{/if}}
