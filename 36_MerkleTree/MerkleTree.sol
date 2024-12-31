pragma solidity ^0.8.21;

import "../34_ERC721/ERC721.sol";

/**
 * 利用Merkle树树验证白名单（生成Merkle树的网页：https://lab.miguelmota.com/merkletreejs/example/）
 * 选上Keccak-256, hashLeaves和sortPairs选项
 * 4个叶子地址：
    [
    "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", 
    "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"
    ]
 * 第一个地址对应的merkle proof
    [
    "0x999bf57501565dbd2fdcea36efa2b9aef8340a8901e3459f4a4c926275d36cdb",
    "0x4726e4102af77216b09ccd94f40daa10531c87c4d60bba7f3b3faf5ff9f19b3c"
    ]
 * Merkle root: 0xeeefd63003e0e702cb41cd0043015a6e26ddb38073cc6ffeb0ba3e808ba8c097
 */

/**
 * @dev 验证Merkle树的合约.
 *
 * proof可以用JavaScript库生成：
 * https://github.com/miguelmota/merkletreejs[merkletreejs].
 * 注意: hash用keccak256，并且开启pair sorting （排序）.
 * javascript例子见 `https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/test/utils/cryptography/MerkleProof.test.js`.
 */

library MerkleProof {
    /**
     * @dev 当通过`proof`和`leaf`重建出的`root`与给定的`root`相等时，返回`true`，数据有效。
     * 在重建时，叶子节点对和元素对都是排序过的。
     */
    function verify(
        bytes32[] memory proof,
        bytes32 root,
        bytes32 leaf
    ) internal pure returns (bool) {
        return processProof(proof, leaf) == root;
    }

    /**
     * @dev Returns 通过Merkle树用`leaf`和`proof`计算出`root`. 当重建出的`root`和给定的`root`相同时，`proof`才是有效的。
     * 在重建时，叶子节点对和元素对都是排序过的。
     */
    function processProof(
        bytes32[] memory proof,
        bytes32 leaf
    ) internal pure returns (bytes32) {
        bytes32 computedHash = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            computedHash = _hashPair(computedHash, proof[i]);
        }
        return computedHash;
    }

    function _hashPair(bytes32 a, bytes32 b) private pure returns (bytes32) {
        return
            a < b
                ? keccak256(abi.encodePacked(a, b))
                : keccak256(abi.encodePacked(b, a));
    }
}

contract MerlkeTree is ERC721{
    bytes32 immutable public root;
    mapping(address => bool) public mintedAddress;
    constructor(string memory name, string memory symbol, bytes32 merkleroot)
    ERC721(name, symbol) {
        root = merkleroot;
    }

    function mint(address account, uint256)


}
