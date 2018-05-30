hab pkg build . --reuse
source results/last_build.env
hab pkg export docker results/$pkg_artifact
source results/last_docker_export.env
# echo docker run -eHAB_NOMAD=\'{"consul": { "address": "http://172.17.0.6:8500", "server_service_name": "nomad", "client_service_name": "nomad-client", "auto_advertise": true, "server_auto_join": true, "client_auto_join": true }}\' $name
echo docker run \$name
