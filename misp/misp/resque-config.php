<?php
$config['CakeResque'] = array(
	'Redis' => array(
		'host' => getenv('REDIS_HOST') ?: 'redis',
		'port' => (int)getenv('REDIS_PORT') ?: 6379,
		'database' => (int)getenv('REDIS_DATABASE') ?: 0,
		'namespace' => getenv('REDIS_NAMESPACE') ?: 'resque',
		'password' => getenv('REDIS_PASSWORD') ?: null
	),
	'Worker' => array(
		'queue' => 'default',
		'interval' => (int)getenv('REDIS_POLL_INTERVAL') ?: 5,
		'workers' => (int)getenv('REDIS_WORKERS_NUM') ?: 1,
		'log' => TMP . 'logs' . DS . 'resque-worker-error.log',
		'verbose' => false
	),
	'Job' => array(
		'track' => false
	),
	'Resque' => array(
		'tmpdir' => App::pluginPath('CakeResque') . 'tmp' . DS
	),
	'Env' => array(),
	'Log' => array(
		'handler' => 'RotatingFile',
		'target' => TMP . 'logs' . DS . 'resque.log'
	),
	'Scheduler' => array(
		'enabled' => true,
		'log' => TMP . 'logs' . DS . 'resque-scheduler-error.log',
		'Env' => array(),
		'Worker' => array(
			'interval' => 3
		),
		'Log' => array(
			'handler' => 'RotatingFile',
			'target' => TMP . 'logs' . DS . 'resque-scheduler.log'
		)
	)
);
