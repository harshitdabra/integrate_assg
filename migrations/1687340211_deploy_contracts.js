const ERC721Token = artifacts.require('ERC721Token');


const ERC20Token = artifacts.require('ERC20Token');

module.exports = function  (deployer)


{

  deployer.deploy(ERC721Token, 'MyERC721', 'ERC721');

  deployer.deploy(ERC20Token, 'MyERC20','ERC20');




};
