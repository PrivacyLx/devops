sudo journalctl -o cat -u snowflake-proxy > /tmp/snowflake-logs.txt
/usr/local/bin/snowflake2exporter.py --no-serve /tmp/snowflake-logs.txt  | sudo tee /var/lib/prometheus/node-exporter/snowflake.prom