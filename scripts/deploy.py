from brownie import MaybeDoubler, accounts, config
from scripts.helpful_scripts import (
    get_account,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)

def main():
    account = accounts.add(config["wallets"]["from_key"])
    chainlink_id = 1178
    MaybeDoubler.deploy(chainlink_id, {'from': account})
    