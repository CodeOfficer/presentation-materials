#!/usr/bin/env ruby

require '../example'

require 'ex8_class_singleton'


example %q{

ClassBasedLogger.level = ClassBasedLogger::INFO

ClassBasedLogger.info('Computer wins chess game.')
ClassBasedLogger.warning('AE-35 hardware failure predicted.')
ClassBasedLogger.error('HAL-9000 malfunction, take emergency action!')

}
