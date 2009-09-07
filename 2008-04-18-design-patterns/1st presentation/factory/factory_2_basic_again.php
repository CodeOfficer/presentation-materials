<?php 
// an example done in php
// ick!

class CharactersFactory {
	private $value;
  public function __construct($value=null) { $this->value = $value; }
	public function getCharacter() { 		
		if (preg_match("/^[A-Za-z]+$/", $this->value)) {
			return new Letters($this->value);
		} elseif (preg_match("/^[0-9]+$/", $this->value)) {
			return new Numbers($this->value);
		} else {
			return new Others($this->value);
		}
	}
}

abstract class Characters { 
	protected $value;		
  protected function __construct($value=null) { $this->setValue($value); }
	public function getValue() { return $this->value; }
	public function setValue($value) { $this->value = $value; }
	public function __toString() {
		return get_class($this).": ".$this->getValue()."\n";
	}
}

class Letters extends Characters {
  public function __construct($value=null) { parent::__construct($value); }
}
class Numbers extends Characters {
  public function __construct($value=null) { parent::__construct($value); }
}
class Others extends Characters {
  public function __construct($value=null) { parent::__construct($value); }
}

// initialize some variables
$test_characters = array('12345', '1o1', 'ruby', '8675309', '•••', 'whatever', 'OU812', '^%$#^%$');
$factory_results = array();

// build an array of factory_results from our test_characters
foreach ($test_characters as $key => $value) {
	$factory = new CharactersFactory($value);
	$factory_results[$key] = $factory->getCharacter();
}

// sort factory_results by its object's class names
// passes an anonymous function to usort for the sorting
usort($factory_results, 
	create_function( 
		'$a, $b', 
		'if (get_class($a) == get_class($b)) { return 0; } '
		.'return (get_class($a) < get_class($b)) ? -1 : 1;'
	) 
);

// output factory_results with the Character's __toString
foreach ($factory_results as $key => $value) {
	echo $factory_results[$key];
}

?>