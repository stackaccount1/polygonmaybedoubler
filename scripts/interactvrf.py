from brownie import MaybeDoubler, accounts, config
from scripts.helpful_scripts import (
    get_account,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)

def main():
    account = accounts.add(config["wallets"]["from_key"])
    MB = "0xd7aFC96613c5f5a32040e5B9b1f5456fe46B4eb2"
    return MB.returnBalance({'from': account})