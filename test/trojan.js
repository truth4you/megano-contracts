
const { expect } = require("chai")
const { ethers, waffle, upgrades } = require("hardhat")
const fs = require('fs')

const toTimestamp = (date) => parseInt(date==undefined?new Date():new Date(date)/1000)
const setBlockTime = async (date)=>{
  await network.provider.send("evm_setNextBlockTimestamp", [parseInt(date==undefined?new Date():new Date(date)/1000)] )
  await network.provider.send("evm_mine") 
}

describe("MEGANO", ()=>{
  let owner, addr1, addr2, addrs;
  let Token, RouterContract, Presale;

  describe("Deploy", () => {
    it("Deploy", async () => {
      [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
      
      const WETHContract = await ethers.getContractFactory("WETH9");
      WETH = await WETHContract.deploy();
      console.log("WETH",WETH.address)
      // factory deploy
      Factory = await ethers.getContractFactory("UniswapV2Factory");
      FactoryContract = await Factory.deploy(WETH.address);
      console.log("factory", FactoryContract.address)
      console.log("initcode", await FactoryContract.INIT_CODE_PAIR_HASH())
      
      // Router deploy
      Router = await ethers.getContractFactory("UniswapV2Router02");
      RouterContract = await Router.deploy(FactoryContract.address, WETH.address);
      console.log("Router", RouterContract.address)

      const tokenFactory = await ethers.getContractFactory("MEGANO")
      Token = await tokenFactory.deploy();
      // const Token = await upgrades.deployProxy(tokenFactory,[RouterContract.address])
      await Token.deployed()
      // const implAddress = await getImplementationAddress(ethers.provider, contract.address);
        
      console.log("Token",Token.address)

      const presaleFactory = await ethers.getContractFactory("Crowdsale")
      Presale = await presaleFactory.deploy("1", addr1.address, Token.address)

    })

    it("Add Liquidity", async ()=>{
      
      await(await Token.approve(RouterContract.address, ethers.utils.parseEther("100000000"))).wait()
      await(await RouterContract.addLiquidityETH(Token.address, ethers.utils.parseEther("100000000") ,"0","0", owner.address, parseInt(new Date().getTime()/1000)+100 ,{ value: ethers.utils.parseEther("1000") })).wait()

    })

    it("initial params setting", async ()=>{
      await(await Token.setInitialDistributionFinished(true)).wait()
      await(await Token.transfer("0x000000000000000000000000000000000000CcCc", ethers.utils.parseEther("1000000"))).wait()
    })
  })

  describe("Presale",()=>{
    it("but token from presale", async ()=>{
      console.log("addr1", await addr1.getBalance())
      console.log("addr2", await addr2.getBalance())
      await(await Presale.connect(addr2).buyTokens(addr2.address, {value: ethers.utils.parseEther("10")})).wait()
      console.log("addr1", await addr1.getBalance())
      console.log("addr2", await addr2.getBalance())
    })
  })
  
  describe("Buy and sell", () => {
    
    it("buy token from Router" ,async ()=>{
      await(await RouterContract.connect(addr1).swapExactETHForTokens(0,[await(RouterContract.WETH()),Token.address],addr1.address,parseInt(new Date().getTime()/1000)+100,{value:ethers.utils.parseEther("10")} )).wait()
    })
    it("Sell token from Router" ,async ()=>{
        console.log(await Token.balanceOf(addr1.address))
        await(await Token.connect(addr1).approve(RouterContract.address,ethers.utils.parseEther("100000000"))).wait()
        await(await RouterContract.connect(addr1).swapExactTokensForETHSupportingFeeOnTransferTokens("9680389710687340343372",0,[Token.address,await(RouterContract.WETH())],addr1.address,parseInt(new Date().getTime()/1000+1000) )).wait()
        const amount = await Token.balanceOf(addr1.address)
        console.log(amount)
        console.log(await Token.numberOfHolders())
    })
    it("manual rebase", async () => {
        const beforRebase = await Token.balanceOf(addr1.address)
        await network.provider.send("evm_increaseTime", [1 * 86400]);
        await network.provider.send("evm_mine");
        await(await Token.manualRebase()).wait()
        console.log("pairPrice",await Token.getPriceFromPair())
        expect(await Token.balanceOf(addr1.address)).to.equal(beforRebase.mul(10200).div(10000))
    })

    it("lock", async () => {
      const amount = await Token.balanceOf(addr1.address)
      await(await Token.connect(addr1).lock(10,ethers.utils.parseEther("1000"))).wait()
      console.log("addr1Amount after lock", ethers.utils.formatEther(await Token.balanceOf(addr1.address)))
    })
    // it("unlock error", async () => {
    //   expect(Token.connect(addr1).unlock(0)).to.be.revertedWith("Unlock: Pending.")
    // })
    it("unlock", async () => {
      await network.provider.send("evm_increaseTime", [10 * 86400]);
      await network.provider.send("evm_mine");
      await(await Token.connect(addr1).unlock(0)).wait()
      console.log("addr1Amount after unlock", ethers.utils.formatEther(await Token.balanceOf(addr1.address)))
    })
    it("manual rebase", async () => {
      const beforRebase = await Token.balanceOf(addr1.address)
      await network.provider.send("evm_increaseTime", [1 * 86400]);
      await network.provider.send("evm_mine");
      await(await Token.manualRebase()).wait()
      console.log(ethers.utils.formatEther(await Token.balanceOf(addr1.address)))
      expect(await Token.balanceOf(addr1.address)).to.equal(beforRebase.mul(10200).div(10000))
    })
    
  })

})



  

