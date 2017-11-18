vcl 4.0;

backend default {
	.host = "127.0.0.1";
	.port = "8080";
	.connect_timeout = 60s;
	.first_byte_timeout = 60s;
	.between_bytes_timeout = 60s;
	.max_connections = 800;
}
