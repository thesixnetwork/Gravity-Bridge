export GRAVITY_HOME=~/.gravity_test
export MONIKER=deenode
export VALKEY=validator1
export ORCKEY=orch1

rm -Rf ${GRAVITY_HOME}

gravity init ${MONIKER} --home ${GRAVITY_HOME}
export CHAIN_ID=`jq -r '.chain_id' ${GRAVITY_HOME}/config/genesis.json`

gravity keys add ${VALKEY} --keyring-backend test --home ${GRAVITY_HOME}
gravity keys add ${ORCKEY} --keyring-backend test --home ${GRAVITY_HOME}
export VAL_ADDRESS="gravity10rf64ne45pw0mcuehs7gnacmnqxumn7w45rgn8"
export ORC_ADDRESS="gravity1p7pt83v4e2xqulmwal2gv3lhwelhg54v4gann7"

gravity eth_keys add --keyring-backend test --home ${GRAVITY_HOME}
export ETH_ADDRESS="0x7191c9937c3B0a4A32157072C9fc3Be050100dcb"

gravity add-genesis-account ${VALKEY} 1000000000000stake --keyring-backend test --home ${GRAVITY_HOME}
gravity add-genesis-account ${ORCKEY} 1000000000000stake --keyring-backend test --home ${GRAVITY_HOME}

# modify nativeHRP
code ${GRAVITY_HOME}/config/genesis.json

gravity gentx --moniker=${MONIKER} ${VALKEY} 1000000000stake \
    ${ETH_ADDRESS} ${VAL_ADDRESS} --chain-id=${CHAIN_ID} \
    --keyring-backend test --home ${GRAVITY_HOME}
gravity collect-gentxs --home ${GRAVITY_HOME}

# backup
cp -r ${GRAVITY_HOME} ${GRAVITY_HOME}_backup

gravity start --home ${GRAVITY_HOME}


# other cmds
gravity keys list --keyring-backend test --home ${GRAVITY_HOME}
# restore
rm -Rf ${GRAVITY_HOME}
cp -r ${GRAVITY_HOME}_backup ${GRAVITY_HOME}

notes

# private: 0x8a6ee60fce6e5a21a644dd6fd585363bf1b2a61563451a3a7394b1e0e607c1d1 
# public: 0x04c87baaa009cf0df2cd7bc88126b3d0966a439c37011e699d164fafb57a36211ccef8945aef1d3bb8c1f2d6cd4e5dc96ece0dd988c5f7afee526a39e63c3a3630 
# address: 0x194eF67Fc816267937f2710d7525dd56407f1316