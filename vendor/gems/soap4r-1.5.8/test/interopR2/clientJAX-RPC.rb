#!/usr/bin/env ruby

$serverName = 'JAX-RPC'

$serverBase = 'http://soapinterop.java.sun.com:80/round2/base'
$serverGroupB = 'http://soapinterop.java.sun.com:80/round2/groupb'
$noEchoMap = true

require 'clientBase'

drvBase = SOAP::RPC::Driver.new($serverBase, InterfaceNS)
methodDef( drvBase )

drvGroupB = SOAP::RPC::Driver.new($serverGroupB, InterfaceNS)
methodDefGroupB( drvGroupB )

doTestBase( drvBase )
doTestGroupB( drvGroupB )
submitTestResult
