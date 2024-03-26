import { CONTRACT_ADDRESSES, ConnectWallet, useContract, useContractRead, useContractWrite, useAddress } from "@thirdweb-dev/react";
import styles from "../styles/Home.module.css";
import { useState } from 'react';
import { ethers } from 'ethers';
import { CONTRACT_ADDRESS } from "../constants/addresses";

const Home = () => {
  const { contract } = useContract(CONTRACT_ADDRESS);
  const address = useAddress();
  const [depositAmount, setDepositAmount] = useState('');

  const { data: etherBalance, isLoading: isBalanceLoading } = useContractRead(contract, "addressToValue", [address]);
  const { mutateAsync: deposit } = useContractWrite(contract, "deposit");
  const { mutateAsync: withdraw } = useContractWrite(contract, "withdraw");

  const handleDeposit = async () => {
    if (!depositAmount) return;
    try {
      await deposit({
        args: [],
        overrides: { value: ethers.utils.parseEther(depositAmount) },
      });
      console.info("Deposit success");
    } catch (err) {
      console.error("Deposit failure", err);
    }
  };

  const handleWithdraw = async () => {
    try {
      await withdraw({
        args: [],
      });
      console.info("Withdraw success");
    } catch (err) {
      console.error("Withdraw failure", err);
    }
  };

  return (
    <main className={styles.main}>
      <div className={styles.container}>
        <div className={styles.walletConnectContainer}>
          <ConnectWallet />
        </div>
        <h1 className={styles.gradientText0}>Your Personal Bank Account</h1>
        <div className={styles.contentWrapper}>
          <div className={styles.balanceContainer}>
            {isBalanceLoading || !etherBalance ? (
              <p className={styles.balanceText}>0 ETH</p>
            ) : (
              <p className={styles.balanceText}>
                {etherBalance ? ethers.utils.formatEther(etherBalance) : "0"} ETH
              </p>
            )}
          </div>
          {address && (
            <div className={styles.buttonContainer}>
              <input
                type="text"
                className={styles.depositInput}
                placeholder="Amount to deposit"
                value={depositAmount}
                onChange={(e) => setDepositAmount(e.target.value)}
              />
              <button className={styles.actionButton} onClick={handleDeposit}>Deposit</button>
              <button className={styles.actionButton} onClick={handleWithdraw}>Withdraw All</button>
            </div>
          )}
        </div>
      </div>
    </main>
  );
};

export default Home;
