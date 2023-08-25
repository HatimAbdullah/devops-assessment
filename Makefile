cluster:
	k3d cluster create sandman \
	    -p 8080:80@loadbalancer \
	    -v /etc/machine-id:/etc/machine-id:ro \
	    -v /var/log/journal:/var/log/journal:ro \
	    -v /var/run/docker.sock:/var/run/docker.sock \
	    --k3s-arg="--disable=traefik@server:0" \   # Disabling the default Traefik deployment using K3s’ --disable=traefik flag.
	    --agents 0
