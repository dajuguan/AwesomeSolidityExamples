# usage
## deploy TestMerkelProof.sol 
- call `getProof` with params: `index`(0,1,2,3), you will get the `proof data`:

> `0:
bytes32[]: 0x6af6ecc11d74287599ff0eca904205acafe9bf8f75e1b7412b21d62d4bf258ae,0xe87176622b0b0edd5a6356d9735a59aef2a3c5cb7cb90d9a028cc9ee14b242db
`


- call `verify` with `index` and the above `proof data`:
> `2,["0x85d08e0c4885f7863600ad9167e2f283bf07605f4c3421c6759309681f4fcd45","0x52ec2a1ebda5e602ad097c7bab021d4ee7965a001b7c54aeac30f48e1701aab9"]
`

- you will get `true or false`.

