# HELP alloy_build_info A metric with a constant '1' value labeled by version, revision, branch, goversion from which alloy was built, and the goos and goarch for the build.
# TYPE alloy_build_info gauge
alloy_build_info{branch="HEAD",goarch="arm64",goos="linux",goversion="go1.24.6",revision="eebd230",tags="netgo,builtinassets,promtail_journal_enabled",version="v1.11.1"} 1
# HELP alloy_component_controller_evaluating Tracks if the controller is currently in the middle of a graph evaluation
# TYPE alloy_component_controller_evaluating gauge
alloy_component_controller_evaluating{controller_id="",controller_path="/"} 0
alloy_component_controller_evaluating{controller_id="remotecfg",controller_path="/"} 0
# HELP alloy_component_controller_running_components Total number of running components.
# TYPE alloy_component_controller_running_components gauge
alloy_component_controller_running_components{controller_id="",controller_path="/",health_type="healthy"} 8
# HELP alloy_component_dependencies_wait_seconds Time spent by components waiting to be evaluated after their dependency is updated.
# TYPE alloy_component_dependencies_wait_seconds histogram
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="0.005"} 4
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="0.025"} 4
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="0.1"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="0.5"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="1"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="5"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="10"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="30"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="60"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="120"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="300"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="600"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="",controller_path="/",le="+Inf"} 5
alloy_component_dependencies_wait_seconds_sum{controller_id="",controller_path="/"} 0.07431874899999999
alloy_component_dependencies_wait_seconds_count{controller_id="",controller_path="/"} 5
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="0.005"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="0.025"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="0.1"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="0.5"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="1"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="5"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="10"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="30"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="60"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="120"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="300"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="600"} 0
alloy_component_dependencies_wait_seconds_bucket{controller_id="remotecfg",controller_path="/",le="+Inf"} 0
alloy_component_dependencies_wait_seconds_sum{controller_id="remotecfg",controller_path="/"} 0
alloy_component_dependencies_wait_seconds_count{controller_id="remotecfg",controller_path="/"} 0
# HELP alloy_component_evaluation_queue_size Tracks the number of components waiting to be evaluated in the worker pool
# TYPE alloy_component_evaluation_queue_size gauge
alloy_component_evaluation_queue_size{controller_id="",controller_path="/"} 5
alloy_component_evaluation_queue_size{controller_id="remotecfg",controller_path="/"} 0
# HELP alloy_component_evaluation_seconds Time spent performing component evaluation
# TYPE alloy_component_evaluation_seconds histogram
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="0.005"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="0.025"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="0.1"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="0.5"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="1"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="5"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="10"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="30"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="60"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="120"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="300"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="600"} 5
alloy_component_evaluation_seconds_bucket{controller_id="",controller_path="/",le="+Inf"} 5
alloy_component_evaluation_seconds_sum{controller_id="",controller_path="/"} 0.0006175
alloy_component_evaluation_seconds_count{controller_id="",controller_path="/"} 5
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="0.005"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="0.025"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="0.1"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="0.5"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="1"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="5"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="10"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="30"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="60"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="120"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="300"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="600"} 0
alloy_component_evaluation_seconds_bucket{controller_id="remotecfg",controller_path="/",le="+Inf"} 0
alloy_component_evaluation_seconds_sum{controller_id="remotecfg",controller_path="/"} 0
alloy_component_evaluation_seconds_count{controller_id="remotecfg",controller_path="/"} 0
# HELP alloy_config_hash Hash of the currently active config file.
# TYPE alloy_config_hash gauge
alloy_config_hash{cluster_name="",sha256="71bf28b8564e3d126a6cc7594e440bd3b215a2d1c215224f85996f9f9d8d0f26"} 1
# HELP alloy_config_last_load_success_timestamp_seconds Timestamp of the last successful configuration load.
# TYPE alloy_config_last_load_success_timestamp_seconds gauge
alloy_config_last_load_success_timestamp_seconds 1.7627661386237044e+09
# HELP alloy_config_last_load_successful Config loaded successfully.
# TYPE alloy_config_last_load_successful gauge
alloy_config_last_load_successful 1
# HELP alloy_config_load_failures_total Configuration load failures.
# TYPE alloy_config_load_failures_total counter
alloy_config_load_failures_total 0
# HELP alloy_labelstore_global_ids_count Total number of global ids.
# TYPE alloy_labelstore_global_ids_count gauge
alloy_labelstore_global_ids_count 3242
# HELP alloy_labelstore_last_stale_check_timestamp Last time stale check was ran expressed in unix timestamp.
# TYPE alloy_labelstore_last_stale_check_timestamp gauge
alloy_labelstore_last_stale_check_timestamp 1.762766738e+09
# HELP alloy_labelstore_remote_store_ids_count Total number of ids per remote write
# TYPE alloy_labelstore_remote_store_ids_count gauge
alloy_labelstore_remote_store_ids_count{remote_name="prometheus.remote_write.default"} 3242
# HELP alloy_resources_machine_rx_bytes_total Total bytes, host-wide, received across all network interfaces.
# TYPE alloy_resources_machine_rx_bytes_total counter
alloy_resources_machine_rx_bytes_total 830825
# HELP alloy_resources_machine_tx_bytes_total Total bytes, host-wide, sent across all given network interface.
# TYPE alloy_resources_machine_tx_bytes_total counter
alloy_resources_machine_tx_bytes_total 8.06373e+06
# HELP alloy_resources_process_cpu_seconds_total Total user and system CPU time spent in seconds.
# TYPE alloy_resources_process_cpu_seconds_total counter
alloy_resources_process_cpu_seconds_total 18.71
# HELP alloy_resources_process_resident_memory_bytes Current resident memory size in bytes.
# TYPE alloy_resources_process_resident_memory_bytes gauge
alloy_resources_process_resident_memory_bytes 2.81747456e+08
# HELP alloy_resources_process_start_time_seconds Start time of the process since Unix epoch in seconds.
# TYPE alloy_resources_process_start_time_seconds gauge
alloy_resources_process_start_time_seconds 1.762766137e+09
# HELP alloy_resources_process_virtual_memory_bytes Current virtual memory size in bytes.
# TYPE alloy_resources_process_virtual_memory_bytes gauge
alloy_resources_process_virtual_memory_bytes 2.844463104e+09
# HELP deprecated_flags_inuse_total The number of deprecated flags currently set.
# TYPE deprecated_flags_inuse_total counter
deprecated_flags_inuse_total 0
# HELP go_gc_duration_seconds A summary of the wall-time pause (stop-the-world) duration in garbage collection cycles.
# TYPE go_gc_duration_seconds summary
go_gc_duration_seconds{quantile="0"} 0.000159792
go_gc_duration_seconds{quantile="0.25"} 0.000528625
go_gc_duration_seconds{quantile="0.5"} 0.001081167
go_gc_duration_seconds{quantile="0.75"} 0.00163775
go_gc_duration_seconds{quantile="1"} 0.003065875
go_gc_duration_seconds_sum 0.02531996
go_gc_duration_seconds_count 22
# HELP go_gc_gogc_percent Heap size target percentage configured by the user, otherwise 100. This value is set by the GOGC environment variable, and the runtime/debug.SetGCPercent function. Sourced from /gc/gogc:percent.
# TYPE go_gc_gogc_percent gauge
go_gc_gogc_percent 100
# HELP go_gc_gomemlimit_bytes Go runtime memory limit configured by the user, otherwise math.MaxInt64. This value is set by the GOMEMLIMIT environment variable, and the runtime/debug.SetMemoryLimit function. Sourced from /gc/gomemlimit:bytes.
# TYPE go_gc_gomemlimit_bytes gauge
go_gc_gomemlimit_bytes 9.223372036854776e+18
# HELP go_goroutines Number of goroutines that currently exist.
# TYPE go_goroutines gauge
go_goroutines 107
# HELP go_info Information about the Go environment.
# TYPE go_info gauge
go_info{version="go1.24.6"} 1
# HELP go_memstats_alloc_bytes Number of bytes allocated in heap and currently in use. Equals to /memory/classes/heap/objects:bytes.
# TYPE go_memstats_alloc_bytes gauge
go_memstats_alloc_bytes 7.6171704e+07
# HELP go_memstats_alloc_bytes_total Total number of bytes allocated in heap until now, even if released already. Equals to /gc/heap/allocs:bytes.
# TYPE go_memstats_alloc_bytes_total counter
go_memstats_alloc_bytes_total 7.38942192e+08
# HELP go_memstats_buck_hash_sys_bytes Number of bytes used by the profiling bucket hash table. Equals to /memory/classes/profiling/buckets:bytes.
# TYPE go_memstats_buck_hash_sys_bytes gauge
go_memstats_buck_hash_sys_bytes 1.694822e+06
# HELP go_memstats_frees_total Total number of heap objects frees. Equals to /gc/heap/frees:objects + /gc/heap/tiny/allocs:objects.
# TYPE go_memstats_frees_total counter
go_memstats_frees_total 6.556918e+06
# HELP go_memstats_gc_sys_bytes Number of bytes used for garbage collection system metadata. Equals to /memory/classes/metadata/other:bytes.
# TYPE go_memstats_gc_sys_bytes gauge
go_memstats_gc_sys_bytes 4.98168e+06
# HELP go_memstats_heap_alloc_bytes Number of heap bytes allocated and currently in use, same as go_memstats_alloc_bytes. Equals to /memory/classes/heap/objects:bytes.
# TYPE go_memstats_heap_alloc_bytes gauge
go_memstats_heap_alloc_bytes 7.6171704e+07
# HELP go_memstats_heap_idle_bytes Number of heap bytes waiting to be used. Equals to /memory/classes/heap/released:bytes + /memory/classes/heap/free:bytes.
# TYPE go_memstats_heap_idle_bytes gauge
go_memstats_heap_idle_bytes 1.9693568e+07
# HELP go_memstats_heap_inuse_bytes Number of heap bytes that are in use. Equals to /memory/classes/heap/objects:bytes + /memory/classes/heap/unused:bytes
# TYPE go_memstats_heap_inuse_bytes gauge
go_memstats_heap_inuse_bytes 8.667136e+07
# HELP go_memstats_heap_objects Number of currently allocated objects. Equals to /gc/heap/objects:objects.
# TYPE go_memstats_heap_objects gauge
go_memstats_heap_objects 519401
# HELP go_memstats_heap_released_bytes Number of heap bytes released to OS. Equals to /memory/classes/heap/released:bytes.
# TYPE go_memstats_heap_released_bytes gauge
go_memstats_heap_released_bytes 1.179648e+06
# HELP go_memstats_heap_sys_bytes Number of heap bytes obtained from system. Equals to /memory/classes/heap/objects:bytes + /memory/classes/heap/unused:bytes + /memory/classes/heap/released:bytes + /memory/classes/heap/free:bytes.
# TYPE go_memstats_heap_sys_bytes gauge
go_memstats_heap_sys_bytes 1.06364928e+08
# HELP go_memstats_last_gc_time_seconds Number of seconds since 1970 of last garbage collection.
# TYPE go_memstats_last_gc_time_seconds gauge
go_memstats_last_gc_time_seconds 1.762767221234086e+09
# HELP go_memstats_mallocs_total Total number of heap objects allocated, both live and gc-ed. Semantically a counter version for go_memstats_heap_objects gauge. Equals to /gc/heap/allocs:objects + /gc/heap/tiny/allocs:objects.
# TYPE go_memstats_mallocs_total counter
go_memstats_mallocs_total 7.076319e+06
# HELP go_memstats_mcache_inuse_bytes Number of bytes in use by mcache structures. Equals to /memory/classes/metadata/mcache/inuse:bytes.
# TYPE go_memstats_mcache_inuse_bytes gauge
go_memstats_mcache_inuse_bytes 9664
# HELP go_memstats_mcache_sys_bytes Number of bytes used for mcache structures obtained from system. Equals to /memory/classes/metadata/mcache/inuse:bytes + /memory/classes/metadata/mcache/free:bytes.
# TYPE go_memstats_mcache_sys_bytes gauge
go_memstats_mcache_sys_bytes 15704
# HELP go_memstats_mspan_inuse_bytes Number of bytes in use by mspan structures. Equals to /memory/classes/metadata/mspan/inuse:bytes.
# TYPE go_memstats_mspan_inuse_bytes gauge
go_memstats_mspan_inuse_bytes 1.00496e+06
# HELP go_memstats_mspan_sys_bytes Number of bytes used for mspan structures obtained from system. Equals to /memory/classes/metadata/mspan/inuse:bytes + /memory/classes/metadata/mspan/free:bytes.
# TYPE go_memstats_mspan_sys_bytes gauge
go_memstats_mspan_sys_bytes 1.25664e+06
# HELP go_memstats_next_gc_bytes Number of heap bytes when next garbage collection will take place. Equals to /gc/heap/goal:bytes.
# TYPE go_memstats_next_gc_bytes gauge
go_memstats_next_gc_bytes 1.00994226e+08
# HELP go_memstats_other_sys_bytes Number of bytes used for other system allocations. Equals to /memory/classes/other:bytes.
# TYPE go_memstats_other_sys_bytes gauge
go_memstats_other_sys_bytes 1.185514e+06
# HELP go_memstats_stack_inuse_bytes Number of bytes obtained from system for stack allocator in non-CGO environments. Equals to /memory/classes/heap/stacks:bytes.
# TYPE go_memstats_stack_inuse_bytes gauge
go_memstats_stack_inuse_bytes 2.686976e+06
# HELP go_memstats_stack_sys_bytes Number of bytes obtained from system for stack allocator. Equals to /memory/classes/heap/stacks:bytes + /memory/classes/os-stacks:bytes.
# TYPE go_memstats_stack_sys_bytes gauge
go_memstats_stack_sys_bytes 2.686976e+06
# HELP go_memstats_sys_bytes Number of bytes obtained from system. Equals to /memory/classes/total:byte.
# TYPE go_memstats_sys_bytes gauge
go_memstats_sys_bytes 1.18186264e+08
# HELP go_sched_gomaxprocs_threads The current runtime.GOMAXPROCS setting, or the number of operating system threads that can execute user-level Go code simultaneously. Sourced from /sched/gomaxprocs:threads.
# TYPE go_sched_gomaxprocs_threads gauge
go_sched_gomaxprocs_threads 8
# HELP go_threads Number of OS threads created.
# TYPE go_threads gauge
go_threads 17
# HELP loki_experimental_features_in_use_total The number of experimental features in use.
# TYPE loki_experimental_features_in_use_total counter
loki_experimental_features_in_use_total 0
# HELP loki_logql_querystats_duplicates_total Total count of duplicates found while executing LogQL queries.
# TYPE loki_logql_querystats_duplicates_total counter
loki_logql_querystats_duplicates_total 0
# HELP loki_logql_querystats_ingester_sent_lines_total Total count of lines sent from ingesters while executing LogQL queries.
# TYPE loki_logql_querystats_ingester_sent_lines_total counter
loki_logql_querystats_ingester_sent_lines_total 0
# HELP loki_panic_total The total number of panic triggered
# TYPE loki_panic_total counter
loki_panic_total 0
# HELP loki_querier_index_cache_corruptions_total The number of cache corruptions for the index cache.
# TYPE loki_querier_index_cache_corruptions_total counter
loki_querier_index_cache_corruptions_total 0
# HELP loki_querier_index_cache_encode_errors_total The number of errors for the index cache while encoding the body.
# TYPE loki_querier_index_cache_encode_errors_total counter
loki_querier_index_cache_encode_errors_total 0
# HELP loki_querier_index_cache_gets_total The number of gets for the index cache.
# TYPE loki_querier_index_cache_gets_total counter
loki_querier_index_cache_gets_total 0
# HELP loki_querier_index_cache_hits_total The number of cache hits for the index cache.
# TYPE loki_querier_index_cache_hits_total counter
loki_querier_index_cache_hits_total 0
# HELP loki_querier_index_cache_puts_total The number of puts for the index cache.
# TYPE loki_querier_index_cache_puts_total counter
loki_querier_index_cache_puts_total 0
# HELP net_conntrack_dialer_conn_attempted_total Total number of connections attempted by the given dialer a given name.
# TYPE net_conntrack_dialer_conn_attempted_total counter
net_conntrack_dialer_conn_attempted_total{dialer_name="prometheus.scrape.alloy_metrics"} 1
net_conntrack_dialer_conn_attempted_total{dialer_name="prometheus.scrape.cadvisor"} 1
net_conntrack_dialer_conn_attempted_total{dialer_name="prometheus.scrape.system_metrics"} 1
net_conntrack_dialer_conn_attempted_total{dialer_name="prometheus.scrape.telegraf"} 1
net_conntrack_dialer_conn_attempted_total{dialer_name="remote_storage_write_client"} 1
# HELP net_conntrack_dialer_conn_closed_total Total number of connections closed which originated from the dialer of a given name.
# TYPE net_conntrack_dialer_conn_closed_total counter
net_conntrack_dialer_conn_closed_total{dialer_name="prometheus.scrape.alloy_metrics"} 0
net_conntrack_dialer_conn_closed_total{dialer_name="prometheus.scrape.cadvisor"} 0
net_conntrack_dialer_conn_closed_total{dialer_name="prometheus.scrape.system_metrics"} 0
net_conntrack_dialer_conn_closed_total{dialer_name="prometheus.scrape.telegraf"} 0
net_conntrack_dialer_conn_closed_total{dialer_name="remote_storage_write_client"} 0
# HELP net_conntrack_dialer_conn_established_total Total number of connections successfully established by the given dialer a given name.
# TYPE net_conntrack_dialer_conn_established_total counter
net_conntrack_dialer_conn_established_total{dialer_name="prometheus.scrape.alloy_metrics"} 1
net_conntrack_dialer_conn_established_total{dialer_name="prometheus.scrape.cadvisor"} 1
net_conntrack_dialer_conn_established_total{dialer_name="prometheus.scrape.system_metrics"} 1
net_conntrack_dialer_conn_established_total{dialer_name="prometheus.scrape.telegraf"} 1
net_conntrack_dialer_conn_established_total{dialer_name="remote_storage_write_client"} 1
# HELP net_conntrack_dialer_conn_failed_total Total number of connections failed to dial by the dialer a given name.
# TYPE net_conntrack_dialer_conn_failed_total counter
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.alloy_metrics",reason="refused"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.alloy_metrics",reason="resolution"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.alloy_metrics",reason="timeout"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.alloy_metrics",reason="unknown"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.cadvisor",reason="refused"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.cadvisor",reason="resolution"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.cadvisor",reason="timeout"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.cadvisor",reason="unknown"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.system_metrics",reason="refused"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.system_metrics",reason="resolution"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.system_metrics",reason="timeout"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.system_metrics",reason="unknown"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.telegraf",reason="refused"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.telegraf",reason="resolution"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.telegraf",reason="timeout"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="prometheus.scrape.telegraf",reason="unknown"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="remote_storage_write_client",reason="refused"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="remote_storage_write_client",reason="resolution"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="remote_storage_write_client",reason="timeout"} 0
net_conntrack_dialer_conn_failed_total{dialer_name="remote_storage_write_client",reason="unknown"} 0
# HELP postgres_exporter_config_last_reload_success_timestamp_seconds Timestamp of the last successful configuration reload.
# TYPE postgres_exporter_config_last_reload_success_timestamp_seconds gauge
postgres_exporter_config_last_reload_success_timestamp_seconds 0
# HELP postgres_exporter_config_last_reload_successful Postgres exporter config loaded successfully.
# TYPE postgres_exporter_config_last_reload_successful gauge
postgres_exporter_config_last_reload_successful 0
# HELP process_cpu_seconds_total Total user and system CPU time spent in seconds.
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total 18.71
# HELP process_max_fds Maximum number of open file descriptors.
# TYPE process_max_fds gauge
process_max_fds 1.048576e+06
# HELP process_network_receive_bytes_total Number of bytes received by the process over the network.
# TYPE process_network_receive_bytes_total counter
process_network_receive_bytes_total 807859
# HELP process_network_transmit_bytes_total Number of bytes sent by the process over the network.
# TYPE process_network_transmit_bytes_total counter
process_network_transmit_bytes_total 8.036192e+06
# HELP process_open_fds Number of open file descriptors.
# TYPE process_open_fds gauge
process_open_fds 23
# HELP process_resident_memory_bytes Resident memory size in bytes.
# TYPE process_resident_memory_bytes gauge
process_resident_memory_bytes 2.81747456e+08
# HELP process_start_time_seconds Start time of the process since unix epoch in seconds.
# TYPE process_start_time_seconds gauge
process_start_time_seconds 1.76276613742e+09
# HELP process_virtual_memory_bytes Virtual memory size in bytes.
# TYPE process_virtual_memory_bytes gauge
process_virtual_memory_bytes 2.844463104e+09
# HELP process_virtual_memory_max_bytes Maximum amount of virtual memory available in bytes.
# TYPE process_virtual_memory_max_bytes gauge
process_virtual_memory_max_bytes 1.8446744073709552e+19
# HELP prometheus_fanout_latency Write latency for sending to direct and indirect components
# TYPE prometheus_fanout_latency histogram
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="0.005"} 37
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="0.01"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="0.025"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="0.05"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="0.1"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="0.25"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="0.5"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="1"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="2.5"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="5"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="10"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="30"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="60"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.alloy_metrics",component_path="/",le="+Inf"} 38
prometheus_fanout_latency_sum{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0.079926167
prometheus_fanout_latency_count{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 38
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="0.005"} 112
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="0.01"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="0.025"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="0.05"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="0.1"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="0.25"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="0.5"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="1"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="2.5"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="5"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="10"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="30"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="60"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.cadvisor",component_path="/",le="+Inf"} 113
prometheus_fanout_latency_sum{component_id="prometheus.scrape.cadvisor",component_path="/"} 0.26098470000000007
prometheus_fanout_latency_count{component_id="prometheus.scrape.cadvisor",component_path="/"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="0.005"} 60
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="0.01"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="0.025"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="0.05"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="0.1"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="0.25"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="0.5"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="1"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="2.5"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="5"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="10"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="30"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="60"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.system_metrics",component_path="/",le="+Inf"} 76
prometheus_fanout_latency_sum{component_id="prometheus.scrape.system_metrics",component_path="/"} 0.305786415
prometheus_fanout_latency_count{component_id="prometheus.scrape.system_metrics",component_path="/"} 76
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="0.005"} 112
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="0.01"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="0.025"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="0.05"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="0.1"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="0.25"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="0.5"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="1"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="2.5"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="5"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="10"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="30"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="60"} 113
prometheus_fanout_latency_bucket{component_id="prometheus.scrape.telegraf",component_path="/",le="+Inf"} 113
prometheus_fanout_latency_sum{component_id="prometheus.scrape.telegraf",component_path="/"} 0.14001995999999994
prometheus_fanout_latency_count{component_id="prometheus.scrape.telegraf",component_path="/"} 113
# HELP prometheus_forwarded_samples_total Total number of samples sent to downstream components.
# TYPE prometheus_forwarded_samples_total counter
prometheus_forwarded_samples_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 18043
prometheus_forwarded_samples_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 69376
prometheus_forwarded_samples_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 129142
prometheus_forwarded_samples_total{component_id="prometheus.scrape.telegraf",component_path="/"} 47125
# HELP prometheus_remote_storage_bytes_total The total number of bytes of data (not metadata) sent by the queue after compression. Note that when exemplars over remote write is enabled the exemplars included in a remote write request count towards this metric.
# TYPE prometheus_remote_storage_bytes_total counter
prometheus_remote_storage_bytes_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 4.682877e+06
# HELP prometheus_remote_storage_enqueue_retries_total Total number of times enqueue has failed because a shards queue was full.
# TYPE prometheus_remote_storage_enqueue_retries_total counter
prometheus_remote_storage_enqueue_retries_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_exemplars_failed_total Total number of exemplars which failed on send to remote storage, non-recoverable errors.
# TYPE prometheus_remote_storage_exemplars_failed_total counter
prometheus_remote_storage_exemplars_failed_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_exemplars_in_total Exemplars in to remote storage, compare to exemplars out for queue managers.
# TYPE prometheus_remote_storage_exemplars_in_total counter
prometheus_remote_storage_exemplars_in_total 0
# HELP prometheus_remote_storage_exemplars_pending The number of exemplars pending in the queues shards to be sent to the remote storage.
# TYPE prometheus_remote_storage_exemplars_pending gauge
prometheus_remote_storage_exemplars_pending{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_exemplars_retried_total Total number of exemplars which failed on send to remote storage but were retried because the send error was recoverable.
# TYPE prometheus_remote_storage_exemplars_retried_total counter
prometheus_remote_storage_exemplars_retried_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_exemplars_total Total number of exemplars sent to remote storage.
# TYPE prometheus_remote_storage_exemplars_total counter
prometheus_remote_storage_exemplars_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_highest_timestamp_in_seconds Highest timestamp that has come into the remote storage via the Appender interface, in seconds since epoch. Initialized to 0 when no data has been received yet.
# TYPE prometheus_remote_storage_highest_timestamp_in_seconds gauge
prometheus_remote_storage_highest_timestamp_in_seconds{component_id="prometheus.remote_write.default",component_path="/"} 1.762767274e+09
# HELP prometheus_remote_storage_histograms_failed_total Total number of histograms which failed on send to remote storage, non-recoverable errors.
# TYPE prometheus_remote_storage_histograms_failed_total counter
prometheus_remote_storage_histograms_failed_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_histograms_in_total HistogramSamples in to remote storage, compare to histograms out for queue managers.
# TYPE prometheus_remote_storage_histograms_in_total counter
prometheus_remote_storage_histograms_in_total 0
# HELP prometheus_remote_storage_histograms_pending The number of histograms pending in the queues shards to be sent to the remote storage.
# TYPE prometheus_remote_storage_histograms_pending gauge
prometheus_remote_storage_histograms_pending{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_histograms_retried_total Total number of histograms which failed on send to remote storage but were retried because the send error was recoverable.
# TYPE prometheus_remote_storage_histograms_retried_total counter
prometheus_remote_storage_histograms_retried_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_histograms_total Total number of histograms sent to remote storage.
# TYPE prometheus_remote_storage_histograms_total counter
prometheus_remote_storage_histograms_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_max_samples_per_send The maximum number of samples to be sent, in a single request, to the remote storage. Note that, when sending of exemplars over remote write is enabled, exemplars count towards this limt.
# TYPE prometheus_remote_storage_max_samples_per_send gauge
prometheus_remote_storage_max_samples_per_send{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 5000
# HELP prometheus_remote_storage_metadata_bytes_total The total number of bytes of metadata sent by the queue after compression.
# TYPE prometheus_remote_storage_metadata_bytes_total counter
prometheus_remote_storage_metadata_bytes_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_metadata_failed_total Total number of metadata entries which failed on send to remote storage, non-recoverable errors.
# TYPE prometheus_remote_storage_metadata_failed_total counter
prometheus_remote_storage_metadata_failed_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_metadata_retried_total Total number of metadata entries which failed on send to remote storage but were retried because the send error was recoverable.
# TYPE prometheus_remote_storage_metadata_retried_total counter
prometheus_remote_storage_metadata_retried_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_metadata_total Total number of metadata entries sent to remote storage.
# TYPE prometheus_remote_storage_metadata_total counter
prometheus_remote_storage_metadata_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_queue_highest_sent_timestamp_seconds Timestamp from a WAL sample, the highest timestamp successfully sent by this queue, in seconds since epoch. Initialized to 0 when no data has been sent yet.
# TYPE prometheus_remote_storage_queue_highest_sent_timestamp_seconds gauge
prometheus_remote_storage_queue_highest_sent_timestamp_seconds{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 1.762767274e+09
# HELP prometheus_remote_storage_samples_failed_total Total number of samples which failed on send to remote storage, non-recoverable errors.
# TYPE prometheus_remote_storage_samples_failed_total counter
prometheus_remote_storage_samples_failed_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_samples_in_total Samples in to remote storage, compare to samples out for queue managers.
# TYPE prometheus_remote_storage_samples_in_total counter
prometheus_remote_storage_samples_in_total 263686
# HELP prometheus_remote_storage_samples_pending The number of samples pending in the queues shards to be sent to the remote storage.
# TYPE prometheus_remote_storage_samples_pending gauge
prometheus_remote_storage_samples_pending{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_samples_retried_total Total number of samples which failed on send to remote storage but were retried because the send error was recoverable.
# TYPE prometheus_remote_storage_samples_retried_total counter
prometheus_remote_storage_samples_retried_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0
# HELP prometheus_remote_storage_samples_total Total number of samples sent to remote storage.
# TYPE prometheus_remote_storage_samples_total counter
prometheus_remote_storage_samples_total{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 263454
# HELP prometheus_remote_storage_sent_batch_duration_seconds Duration of send calls to the remote storage.
# TYPE prometheus_remote_storage_sent_batch_duration_seconds histogram
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="0.005"} 33
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="0.01"} 102
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="0.025"} 166
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="0.05"} 173
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="0.1"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="0.25"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="0.5"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="1"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="2.5"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="5"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="10"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="25"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="60"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="120"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="300"} 174
prometheus_remote_storage_sent_batch_duration_seconds_bucket{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write",le="+Inf"} 174
prometheus_remote_storage_sent_batch_duration_seconds_sum{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 1.8704075830000002
prometheus_remote_storage_sent_batch_duration_seconds_count{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 174
# HELP prometheus_remote_storage_shard_capacity The capacity of each shard of the queue used for parallel sending to the remote storage.
# TYPE prometheus_remote_storage_shard_capacity gauge
prometheus_remote_storage_shard_capacity{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 10000
# HELP prometheus_remote_storage_shards The number of shards used for parallel sending to the remote storage.
# TYPE prometheus_remote_storage_shards gauge
prometheus_remote_storage_shards{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 1
# HELP prometheus_remote_storage_shards_desired The number of shards that the queues shard calculation wants to run based on the rate of samples in vs. samples out.
# TYPE prometheus_remote_storage_shards_desired gauge
prometheus_remote_storage_shards_desired{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 0.00177631920487729
# HELP prometheus_remote_storage_shards_max The maximum number of shards that the queue is allowed to run.
# TYPE prometheus_remote_storage_shards_max gauge
prometheus_remote_storage_shards_max{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 10
# HELP prometheus_remote_storage_shards_min The minimum number of shards that the queue is allowed to run.
# TYPE prometheus_remote_storage_shards_min gauge
prometheus_remote_storage_shards_min{component_id="prometheus.remote_write.default",component_path="/",remote_name="b1b605",url="http://prometheus:9090/api/v1/write"} 1
# HELP prometheus_remote_storage_string_interner_zero_reference_releases_total The number of times release has been called for strings that are not interned.
# TYPE prometheus_remote_storage_string_interner_zero_reference_releases_total counter
prometheus_remote_storage_string_interner_zero_reference_releases_total 0
# HELP prometheus_remote_write_wal_exemplars_appended_total Total number of exemplars appended to the WAL
# TYPE prometheus_remote_write_wal_exemplars_appended_total counter
prometheus_remote_write_wal_exemplars_appended_total{component_id="prometheus.remote_write.default",component_path="/"} 0
# HELP prometheus_remote_write_wal_out_of_order_samples_total Total number of out of order samples ingestion failed attempts.
# TYPE prometheus_remote_write_wal_out_of_order_samples_total counter
prometheus_remote_write_wal_out_of_order_samples_total{component_id="prometheus.remote_write.default",component_path="/"} 0
# HELP prometheus_remote_write_wal_samples_appended_total Total number of samples appended to the WAL
# TYPE prometheus_remote_write_wal_samples_appended_total counter
prometheus_remote_write_wal_samples_appended_total{component_id="prometheus.remote_write.default",component_path="/"} 263686
# HELP prometheus_remote_write_wal_storage_active_series Current number of active series being tracked by the WAL storage
# TYPE prometheus_remote_write_wal_storage_active_series gauge
prometheus_remote_write_wal_storage_active_series{component_id="prometheus.remote_write.default",component_path="/"} 3242
# HELP prometheus_remote_write_wal_storage_created_series_total Total number of created series appended to the WAL
# TYPE prometheus_remote_write_wal_storage_created_series_total counter
prometheus_remote_write_wal_storage_created_series_total{component_id="prometheus.remote_write.default",component_path="/"} 3242
# HELP prometheus_remote_write_wal_storage_deleted_series Current number of series marked for deletion from memory
# TYPE prometheus_remote_write_wal_storage_deleted_series gauge
prometheus_remote_write_wal_storage_deleted_series{component_id="prometheus.remote_write.default",component_path="/"} 0
# HELP prometheus_remote_write_wal_storage_removed_series_total Total number of created series removed from the WAL
# TYPE prometheus_remote_write_wal_storage_removed_series_total counter
prometheus_remote_write_wal_storage_removed_series_total{component_id="prometheus.remote_write.default",component_path="/"} 0
# HELP prometheus_scrape_targets_gauge Number of targets this component is configured to scrape
# TYPE prometheus_scrape_targets_gauge gauge
prometheus_scrape_targets_gauge{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 1
prometheus_scrape_targets_gauge{component_id="prometheus.scrape.cadvisor",component_path="/"} 1
prometheus_scrape_targets_gauge{component_id="prometheus.scrape.system_metrics",component_path="/"} 1
prometheus_scrape_targets_gauge{component_id="prometheus.scrape.telegraf",component_path="/"} 1
# HELP prometheus_scrape_targets_moved_total Number of targets that have moved from this cluster node to another one
# TYPE prometheus_scrape_targets_moved_total counter
prometheus_scrape_targets_moved_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_scrape_targets_moved_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_scrape_targets_moved_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_scrape_targets_moved_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_interval_length_seconds Actual intervals between scrapes.
# TYPE prometheus_target_interval_length_seconds summary
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.alloy_metrics",component_path="/",interval="30s",quantile="0.01"} 29.998125014
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.alloy_metrics",component_path="/",interval="30s",quantile="0.05"} 29.998125014
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.alloy_metrics",component_path="/",interval="30s",quantile="0.5"} 29.999820347
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.alloy_metrics",component_path="/",interval="30s",quantile="0.9"} 30.001484639
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.alloy_metrics",component_path="/",interval="30s",quantile="0.99"} 30.001676805
prometheus_target_interval_length_seconds_sum{component_id="prometheus.scrape.alloy_metrics",component_path="/",interval="30s"} 1110.00146655
prometheus_target_interval_length_seconds_count{component_id="prometheus.scrape.alloy_metrics",component_path="/",interval="30s"} 37
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.cadvisor",component_path="/",interval="10s",quantile="0.01"} 9.996108629
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.cadvisor",component_path="/",interval="10s",quantile="0.05"} 9.996842088
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.cadvisor",component_path="/",interval="10s",quantile="0.5"} 10.000046588
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.cadvisor",component_path="/",interval="10s",quantile="0.9"} 10.003047795
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.cadvisor",component_path="/",interval="10s",quantile="0.99"} 10.004361921
prometheus_target_interval_length_seconds_sum{component_id="prometheus.scrape.cadvisor",component_path="/",interval="10s"} 1120.0172715920003
prometheus_target_interval_length_seconds_count{component_id="prometheus.scrape.cadvisor",component_path="/",interval="10s"} 112
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.system_metrics",component_path="/",interval="15s",quantile="0.01"} 14.995816797
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.system_metrics",component_path="/",interval="15s",quantile="0.05"} 14.995882257
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.system_metrics",component_path="/",interval="15s",quantile="0.5"} 15.000218006
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.system_metrics",component_path="/",interval="15s",quantile="0.9"} 15.003913673
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.system_metrics",component_path="/",interval="15s",quantile="0.99"} 15.004834881
prometheus_target_interval_length_seconds_sum{component_id="prometheus.scrape.system_metrics",component_path="/",interval="15s"} 1125.002877764
prometheus_target_interval_length_seconds_count{component_id="prometheus.scrape.system_metrics",component_path="/",interval="15s"} 75
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.telegraf",component_path="/",interval="10s",quantile="0.01"} 9.99473738
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.telegraf",component_path="/",interval="10s",quantile="0.05"} 9.997529004
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.telegraf",component_path="/",interval="10s",quantile="0.5"} 10.000156505
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.telegraf",component_path="/",interval="10s",quantile="0.9"} 10.001973004
prometheus_target_interval_length_seconds{component_id="prometheus.scrape.telegraf",component_path="/",interval="10s",quantile="0.99"} 10.004800213
prometheus_target_interval_length_seconds_sum{component_id="prometheus.scrape.telegraf",component_path="/",interval="10s"} 1120.0027332150007
prometheus_target_interval_length_seconds_count{component_id="prometheus.scrape.telegraf",component_path="/",interval="10s"} 112
# HELP prometheus_target_metadata_cache_bytes The number of bytes that are currently used for storing metric metadata in the cache
# TYPE prometheus_target_metadata_cache_bytes gauge
prometheus_target_metadata_cache_bytes{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics"} 12858
prometheus_target_metadata_cache_bytes{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor"} 3027
prometheus_target_metadata_cache_bytes{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics"} 12871
prometheus_target_metadata_cache_bytes{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf"} 6685
# HELP prometheus_target_metadata_cache_entries Total number of metric metadata entries in the cache
# TYPE prometheus_target_metadata_cache_entries gauge
prometheus_target_metadata_cache_entries{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics"} 160
prometheus_target_metadata_cache_entries{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor"} 60
prometheus_target_metadata_cache_entries{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics"} 276
prometheus_target_metadata_cache_entries{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf"} 194
# HELP prometheus_target_scrape_pool_exceeded_label_limits_total Total number of times scrape pools hit the label limits, during sync or config reload.
# TYPE prometheus_target_scrape_pool_exceeded_label_limits_total counter
prometheus_target_scrape_pool_exceeded_label_limits_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrape_pool_exceeded_label_limits_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrape_pool_exceeded_label_limits_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrape_pool_exceeded_label_limits_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrape_pool_exceeded_target_limit_total Total number of times scrape pools hit the target limit, during sync or config reload.
# TYPE prometheus_target_scrape_pool_exceeded_target_limit_total counter
prometheus_target_scrape_pool_exceeded_target_limit_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrape_pool_exceeded_target_limit_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrape_pool_exceeded_target_limit_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrape_pool_exceeded_target_limit_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrape_pool_reloads_failed_total Total number of failed scrape pool reloads.
# TYPE prometheus_target_scrape_pool_reloads_failed_total counter
prometheus_target_scrape_pool_reloads_failed_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrape_pool_reloads_failed_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrape_pool_reloads_failed_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrape_pool_reloads_failed_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrape_pool_reloads_total Total number of scrape pool reloads.
# TYPE prometheus_target_scrape_pool_reloads_total counter
prometheus_target_scrape_pool_reloads_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrape_pool_reloads_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrape_pool_reloads_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrape_pool_reloads_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrape_pool_symboltable_items Current number of symbols in table for this scrape pool.
# TYPE prometheus_target_scrape_pool_symboltable_items gauge
prometheus_target_scrape_pool_symboltable_items{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics"} 0
prometheus_target_scrape_pool_symboltable_items{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor"} 0
prometheus_target_scrape_pool_symboltable_items{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics"} 0
prometheus_target_scrape_pool_symboltable_items{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf"} 0
# HELP prometheus_target_scrape_pool_sync_total Total number of syncs that were executed on a scrape pool.
# TYPE prometheus_target_scrape_pool_sync_total counter
prometheus_target_scrape_pool_sync_total{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics"} 1
prometheus_target_scrape_pool_sync_total{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor"} 1
prometheus_target_scrape_pool_sync_total{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics"} 1
prometheus_target_scrape_pool_sync_total{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf"} 1
# HELP prometheus_target_scrape_pool_target_limit Maximum number of targets allowed in this scrape pool.
# TYPE prometheus_target_scrape_pool_target_limit gauge
prometheus_target_scrape_pool_target_limit{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics"} 0
prometheus_target_scrape_pool_target_limit{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor"} 0
prometheus_target_scrape_pool_target_limit{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics"} 0
prometheus_target_scrape_pool_target_limit{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf"} 0
# HELP prometheus_target_scrape_pool_targets Current number of targets in this scrape pool.
# TYPE prometheus_target_scrape_pool_targets gauge
prometheus_target_scrape_pool_targets{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics"} 1
prometheus_target_scrape_pool_targets{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor"} 1
prometheus_target_scrape_pool_targets{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics"} 1
prometheus_target_scrape_pool_targets{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf"} 1
# HELP prometheus_target_scrape_pools_failed_total Total number of scrape pool creations that failed.
# TYPE prometheus_target_scrape_pools_failed_total counter
prometheus_target_scrape_pools_failed_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrape_pools_failed_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrape_pools_failed_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrape_pools_failed_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrape_pools_total Total number of scrape pool creation attempts.
# TYPE prometheus_target_scrape_pools_total counter
prometheus_target_scrape_pools_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 1
prometheus_target_scrape_pools_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 1
prometheus_target_scrape_pools_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 1
prometheus_target_scrape_pools_total{component_id="prometheus.scrape.telegraf",component_path="/"} 1
# HELP prometheus_target_scrapes_cache_flush_forced_total How many times a scrape cache was flushed due to getting big while scrapes are failing.
# TYPE prometheus_target_scrapes_cache_flush_forced_total counter
prometheus_target_scrapes_cache_flush_forced_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrapes_cache_flush_forced_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrapes_cache_flush_forced_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrapes_cache_flush_forced_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrapes_exceeded_body_size_limit_total Total number of scrapes that hit the body size limit
# TYPE prometheus_target_scrapes_exceeded_body_size_limit_total counter
prometheus_target_scrapes_exceeded_body_size_limit_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrapes_exceeded_body_size_limit_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrapes_exceeded_body_size_limit_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrapes_exceeded_body_size_limit_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrapes_exceeded_native_histogram_bucket_limit_total Total number of scrapes that hit the native histogram bucket limit and were rejected.
# TYPE prometheus_target_scrapes_exceeded_native_histogram_bucket_limit_total counter
prometheus_target_scrapes_exceeded_native_histogram_bucket_limit_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrapes_exceeded_native_histogram_bucket_limit_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrapes_exceeded_native_histogram_bucket_limit_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrapes_exceeded_native_histogram_bucket_limit_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrapes_exceeded_sample_limit_total Total number of scrapes that hit the sample limit and were rejected.
# TYPE prometheus_target_scrapes_exceeded_sample_limit_total counter
prometheus_target_scrapes_exceeded_sample_limit_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrapes_exceeded_sample_limit_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrapes_exceeded_sample_limit_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrapes_exceeded_sample_limit_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrapes_exemplar_out_of_order_total Total number of exemplar rejected due to not being out of the expected order.
# TYPE prometheus_target_scrapes_exemplar_out_of_order_total counter
prometheus_target_scrapes_exemplar_out_of_order_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrapes_exemplar_out_of_order_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrapes_exemplar_out_of_order_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrapes_exemplar_out_of_order_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrapes_sample_duplicate_timestamp_total Total number of samples rejected due to duplicate timestamps but different values.
# TYPE prometheus_target_scrapes_sample_duplicate_timestamp_total counter
prometheus_target_scrapes_sample_duplicate_timestamp_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrapes_sample_duplicate_timestamp_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrapes_sample_duplicate_timestamp_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrapes_sample_duplicate_timestamp_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrapes_sample_out_of_bounds_total Total number of samples rejected due to timestamp falling outside of the time bounds.
# TYPE prometheus_target_scrapes_sample_out_of_bounds_total counter
prometheus_target_scrapes_sample_out_of_bounds_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrapes_sample_out_of_bounds_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrapes_sample_out_of_bounds_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrapes_sample_out_of_bounds_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_scrapes_sample_out_of_order_total Total number of samples rejected due to not being out of the expected order.
# TYPE prometheus_target_scrapes_sample_out_of_order_total counter
prometheus_target_scrapes_sample_out_of_order_total{component_id="prometheus.scrape.alloy_metrics",component_path="/"} 0
prometheus_target_scrapes_sample_out_of_order_total{component_id="prometheus.scrape.cadvisor",component_path="/"} 0
prometheus_target_scrapes_sample_out_of_order_total{component_id="prometheus.scrape.system_metrics",component_path="/"} 0
prometheus_target_scrapes_sample_out_of_order_total{component_id="prometheus.scrape.telegraf",component_path="/"} 0
# HELP prometheus_target_sync_failed_total Total number of target sync failures.
# TYPE prometheus_target_sync_failed_total counter
prometheus_target_sync_failed_total{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics"} 0
prometheus_target_sync_failed_total{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor"} 0
prometheus_target_sync_failed_total{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics"} 0
prometheus_target_sync_failed_total{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf"} 0
# HELP prometheus_target_sync_length_seconds Actual interval to sync the scrape pool.
# TYPE prometheus_target_sync_length_seconds summary
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics",quantile="0.01"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics",quantile="0.05"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics",quantile="0.5"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics",quantile="0.9"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics",quantile="0.99"} NaN
prometheus_target_sync_length_seconds_sum{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics"} 0.000292083
prometheus_target_sync_length_seconds_count{component_id="prometheus.scrape.alloy_metrics",component_path="/",scrape_job="prometheus.scrape.alloy_metrics"} 1
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor",quantile="0.01"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor",quantile="0.05"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor",quantile="0.5"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor",quantile="0.9"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor",quantile="0.99"} NaN
prometheus_target_sync_length_seconds_sum{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor"} 0.000142625
prometheus_target_sync_length_seconds_count{component_id="prometheus.scrape.cadvisor",component_path="/",scrape_job="prometheus.scrape.cadvisor"} 1
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics",quantile="0.01"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics",quantile="0.05"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics",quantile="0.5"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics",quantile="0.9"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics",quantile="0.99"} NaN
prometheus_target_sync_length_seconds_sum{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics"} 0.000135291
prometheus_target_sync_length_seconds_count{component_id="prometheus.scrape.system_metrics",component_path="/",scrape_job="prometheus.scrape.system_metrics"} 1
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf",quantile="0.01"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf",quantile="0.05"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf",quantile="0.5"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf",quantile="0.9"} NaN
prometheus_target_sync_length_seconds{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf",quantile="0.99"} NaN
prometheus_target_sync_length_seconds_sum{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf"} 0.00019725
prometheus_target_sync_length_seconds_count{component_id="prometheus.scrape.telegraf",component_path="/",scrape_job="prometheus.scrape.telegraf"} 1
# HELP prometheus_template_text_expansion_failures_total The total number of template text expansion failures.
# TYPE prometheus_template_text_expansion_failures_total counter
prometheus_template_text_expansion_failures_total 0
# HELP prometheus_template_text_expansions_total The total number of template text expansions.
# TYPE prometheus_template_text_expansions_total counter
prometheus_template_text_expansions_total 0
# HELP prometheus_treecache_watcher_goroutines The current number of watcher goroutines.
# TYPE prometheus_treecache_watcher_goroutines gauge
prometheus_treecache_watcher_goroutines 0
# HELP prometheus_treecache_zookeeper_failures_total The total number of ZooKeeper failures.
# TYPE prometheus_treecache_zookeeper_failures_total counter
prometheus_treecache_zookeeper_failures_total 0
# HELP prometheus_tsdb_wal_completed_pages_total Total number of completed pages.
# TYPE prometheus_tsdb_wal_completed_pages_total counter
prometheus_tsdb_wal_completed_pages_total{component_id="prometheus.remote_write.default",component_path="/"} 43
# HELP prometheus_tsdb_wal_fsync_duration_seconds Duration of write log fsync.
# TYPE prometheus_tsdb_wal_fsync_duration_seconds summary
prometheus_tsdb_wal_fsync_duration_seconds{component_id="prometheus.remote_write.default",component_path="/",quantile="0.5"} NaN
prometheus_tsdb_wal_fsync_duration_seconds{component_id="prometheus.remote_write.default",component_path="/",quantile="0.9"} NaN
prometheus_tsdb_wal_fsync_duration_seconds{component_id="prometheus.remote_write.default",component_path="/",quantile="0.99"} NaN
prometheus_tsdb_wal_fsync_duration_seconds_sum{component_id="prometheus.remote_write.default",component_path="/"} 0
prometheus_tsdb_wal_fsync_duration_seconds_count{component_id="prometheus.remote_write.default",component_path="/"} 0
# HELP prometheus_tsdb_wal_page_flushes_total Total number of page flushes.
# TYPE prometheus_tsdb_wal_page_flushes_total counter
prometheus_tsdb_wal_page_flushes_total{component_id="prometheus.remote_write.default",component_path="/"} 398
# HELP prometheus_tsdb_wal_record_bytes_saved_total Total number of bytes saved by the optional record compression. Use this metric to learn about the effectiveness compression.
# TYPE prometheus_tsdb_wal_record_bytes_saved_total counter
prometheus_tsdb_wal_record_bytes_saved_total{component_id="prometheus.remote_write.default",component_path="/",compression="snappy"} 1.948323e+06
# HELP prometheus_tsdb_wal_record_part_writes_total Total number of record parts written before flushing.
# TYPE prometheus_tsdb_wal_record_part_writes_total counter
prometheus_tsdb_wal_record_part_writes_total{component_id="prometheus.remote_write.default",component_path="/"} 398
# HELP prometheus_tsdb_wal_record_parts_bytes_written_total Total number of record part bytes written before flushing, including CRC and compression headers.
# TYPE prometheus_tsdb_wal_record_parts_bytes_written_total counter
prometheus_tsdb_wal_record_parts_bytes_written_total{component_id="prometheus.remote_write.default",component_path="/"} 1.431635e+06
# HELP prometheus_tsdb_wal_segment_current Write log segment index that TSDB is currently writing to.
# TYPE prometheus_tsdb_wal_segment_current gauge
prometheus_tsdb_wal_segment_current{component_id="prometheus.remote_write.default",component_path="/"} 0
# HELP prometheus_tsdb_wal_storage_size_bytes Size of the write log directory.
# TYPE prometheus_tsdb_wal_storage_size_bytes gauge
prometheus_tsdb_wal_storage_size_bytes{component_id="prometheus.remote_write.default",component_path="/"} 1.431635e+06
# HELP prometheus_tsdb_wal_truncations_failed_total Total number of write log truncations that failed.
# TYPE prometheus_tsdb_wal_truncations_failed_total counter
prometheus_tsdb_wal_truncations_failed_total{component_id="prometheus.remote_write.default",component_path="/"} 0
# HELP prometheus_tsdb_wal_truncations_total Total number of write log truncations attempted.
# TYPE prometheus_tsdb_wal_truncations_total counter
prometheus_tsdb_wal_truncations_total{component_id="prometheus.remote_write.default",component_path="/"} 0
# HELP prometheus_tsdb_wal_writes_failed_total Total number of write log writes that failed.
# TYPE prometheus_tsdb_wal_writes_failed_total counter
prometheus_tsdb_wal_writes_failed_total{component_id="prometheus.remote_write.default",component_path="/"} 0
# HELP prometheus_wal_watcher_current_segment Current segment the WAL watcher is reading records from.
# TYPE prometheus_wal_watcher_current_segment gauge
prometheus_wal_watcher_current_segment{component_id="prometheus.remote_write.default",component_path="/",consumer="b1b605"} 0
# HELP prometheus_wal_watcher_notifications_skipped_total The number of WAL write notifications that the Watcher has skipped due to already being in a WAL read routine.
# TYPE prometheus_wal_watcher_notifications_skipped_total counter
prometheus_wal_watcher_notifications_skipped_total{component_id="prometheus.remote_write.default",component_path="/",consumer="b1b605"} 0
# HELP prometheus_wal_watcher_record_decode_failures_total Number of records read by the WAL watcher that resulted in an error when decoding.
# TYPE prometheus_wal_watcher_record_decode_failures_total counter
prometheus_wal_watcher_record_decode_failures_total{component_id="prometheus.remote_write.default",component_path="/",consumer="b1b605"} 0
# HELP prometheus_wal_watcher_records_read_total Number of records read by the WAL watcher from the WAL.
# TYPE prometheus_wal_watcher_records_read_total counter
prometheus_wal_watcher_records_read_total{component_id="prometheus.remote_write.default",component_path="/",consumer="b1b605",type="samples"} 340
prometheus_wal_watcher_records_read_total{component_id="prometheus.remote_write.default",component_path="/",consumer="b1b605",type="series"} 15
# HELP prometheus_wal_watcher_samples_sent_pre_tailing_total Number of sample records read by the WAL watcher and sent to remote write during replay of existing WAL.
# TYPE prometheus_wal_watcher_samples_sent_pre_tailing_total counter
prometheus_wal_watcher_samples_sent_pre_tailing_total{component_id="prometheus.remote_write.default",component_path="/",consumer="b1b605"} 0
# HELP promhttp_metric_handler_requests_in_flight Current number of scrapes being served.
# TYPE promhttp_metric_handler_requests_in_flight gauge
promhttp_metric_handler_requests_in_flight 0
# HELP promhttp_metric_handler_requests_total Total number of scrapes by HTTP status code.
# TYPE promhttp_metric_handler_requests_total counter
promhttp_metric_handler_requests_total{code="200"} 38
promhttp_metric_handler_requests_total{code="500"} 0
promhttp_metric_handler_requests_total{code="503"} 0
