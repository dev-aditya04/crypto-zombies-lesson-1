
   // SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.6.0;

/// title ZombieFactory - A contract to create and store zombies with unique DNA .
/// author Aditya .
/// notice This is a beginner-level smart contract built while learning Solidity via CryptoZombies .
/// dev Teaches me about structs, arrays, functions, keccak256 hashing, and events .

contract ZombieFactory {

    /// dev Event to notify when a new zombie is created .
    event NewZombie(uint zombieId, string name, uint dna);

    // Constant to define the number of digits in our zombie DNA .
    uint dnaDigits = 16;

    // Used to ensure DNA is limited to 16 digits (With the help of modulus operation) .
    uint dnaModulus = 10 ** dnaDigits;

    /// dev Defines the structure of our Zombie object .
    struct Zombie {
        string name;   // The name of the zombie
        uint dna;      // A 16-digit pseudo-random DNA that defines the zombie's traits
    }

    /// @dev Array to store all zombies created on-chain
    Zombie[] public zombies;

    /// dev Internal function to create a new zombie and store it in the zombies array .
    /// param _name The name of the zombie
    /// param _dna The 16-digit DNA assigned to this zombie
    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna)); // Add the new Zombie to storage .
        uint id = zombies.length - 1; // Get the index of the newly created zombie .
        emit NewZombie(id, _name, _dna); // Emit the creation event with relevant info .
    }

    /// dev Generates a pseudo-random DNA number based on input string using keccak256 hashing
    /// param _str Input string (usually the zombie name)
    /// return A 16-digit uint representing zombie DNA
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str))); // Convert string to hash
        return rand % dnaModulus; // Ensure it’s only 16 digits
    }

    /// dev Public function to create a zombie with a given name; triggers DNA generation and creation
    /// param _name Name for the zombie
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name); // Generate DNA from name
        _createZombie(_name, randDna); // Call internal function to store zombie
    }

}
