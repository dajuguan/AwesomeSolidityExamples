# usage
# deploy Counter.sol with Contract address : `A`, call getdata to get:`data`
# deploy Multisig.sol
- Deploy Multisig with params: ["add1","add2","add3"],2
- call submitTx with params: `A`, `data`
- call confirmTx with at least 2 acount from `add1 or add2 or add3`
- call executeTx with acount: `add1 or add2 or add3`

you will get the logs with the value increase by 1 from its last value:

`
[
	{
		"from": "0x0813d4a158d06784FDB48323344896B2B1aa0F85",
		"topic": "0x96792de3f6db2c84e3cd8c5d634bd43572ecb071b3c06db765e8e73ce0269f85",
		"event": "ExecuteTx",
		"args": {
			"0": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
			"1": true,
			"2": "0x0000000000000000000000000000000000000000000000000000000000000002",
			"sender": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
			"success": true,
			"value": "0x0000000000000000000000000000000000000000000000000000000000000002"
		}
	}
]
`