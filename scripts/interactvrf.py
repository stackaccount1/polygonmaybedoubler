from brownie import MaybeDoubler, accounts, config
from scripts.helpful_scripts import (
    get_account,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)

def main():
    account = accounts.add(config["wallets"]["from_key"])
    MB = "0xFFAF55E9538Fb9c6ABbecFe988c03C2B192175C1"
    return MB.testCall({'from': account})