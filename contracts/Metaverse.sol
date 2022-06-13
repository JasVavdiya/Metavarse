// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

// Openzeppelin imports
import "@openzeppelin/contracts@4.4.2/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.4.2/access/Ownable.sol";
import "@openzeppelin/contracts@4.4.2/utils/Counters.sol";

contract Metaverse is ERC721, Ownable{

    constructor() ERC721 ("META","MTA"){}

     using Counters for Counters.Counter;

     Counters.Counter private supply;

    uint public maxSupply = 100;

    uint public cost = 1 wei;

    struct Object{
        string name;
        uint8 w;
         uint8 h;
          uint8 d;
           uint8 x;
            uint8 y;
             uint8 z;
       

    }

    mapping(address=>Object[]) NFTOwaner;
    Object[] public objects;

    function getObjects() public view returns(Object[] memory){
        return objects;
    }

    function totalSupply() public view returns(uint){
        return supply.current();
    }

    function mint(string memory _object_name , uint8 _w , uint8 _h , uint8 _d , uint8 _x , uint8 _y , uint8 _z) public payable {

        require(supply.current() <= maxSupply ,"Supply exceeds maximum");
        require(msg.value>=cost , "Insufficient Payment");

        supply.increment();

        _safeMint(msg.sender, supply.current());

        Object memory _newObject = Object(_object_name,_w,_h,_d,_x,_y,_z);
        objects.push(_newObject);
        NFTOwaner[msg.sender].push(_newObject);


    }

    function getOwnerObjects() public view returns(Object[] memory){
        return NFTOwaner[msg.sender];
    }







}
