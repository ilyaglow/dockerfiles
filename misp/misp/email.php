<?php
class EmailConfig {
	// to set the return-path header, simply uncomment the line below and change you@localhost to the desired e-mail address
	public $default = array(
		'transport'            => 'Mail',
		'charset'              => 'utf-8',
		'headers'              => array('Precedence' => 'bulk'),
		//'additionalParameters' => '-f you@localhost'
	);
	public $smtp = array(
		'transport'     => 'Smtp',
		'from'          => array('site@localhost' => 'My Site'),
		'host'          => 'localhost',
		'port'          => 25,
		'timeout'       => 30,
		'username'      => 'user',
		'password'      => 'secret',
		'client'        => null,
		'log'           => false,
		//'charset'       => 'utf-8',
		//'headerCharset' => 'utf-8',
	);
	public $fast = array(
		'from'          => 'you@localhost',
		'sender'        => null,
		'to'            => null,
		'cc'            => null,
		'bcc'           => null,
		'replyTo'       => null,
		'readReceipt'   => null,
		'returnPath'    => null,
		'messageId'     => true,
		'subject'       => null,
		'message'       => null,
		'headers'       => null,
		'viewRender'    => null,
		'template'      => false,
		'layout'        => false,
		'viewVars'      => null,
		'attachments'   => null,
		'emailFormat'   => null,
		'transport'     => 'Smtp',
		'host'          => 'postfix',
		'port'          => 25,
		'timeout'       => 30,
		'username'      => 'user',
		'password'      => 'secret',
		'client'        => null,
		'log'           => true,
		//'charset'       => 'utf-8',
		//'headerCharset' => 'utf-8',
	);
}
