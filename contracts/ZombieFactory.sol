 
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // declare our event here
    event NewZombie(uint id, string name, uint dna);

    // variable;
    uint randomDna;


    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // Mappings
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) internal {

        // and fire it here
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
