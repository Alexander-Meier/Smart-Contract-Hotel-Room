pragma solidity ^0.6.0;

contract HotelRoom {
    
    enum Statuses {Vacant, Occupied}
    address payable public owner;
    Statuses currentStatus;
    
    event Occupy(address occupant, uint value);
    
    constructor() public {
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }
    
    //Check status
    modifier onlyWhileVacant{
        require(currentStatus == Statuses.Vacant, "Currently Occupied!");
        _;
    }
    
    //Check transaction amount
    modifier costs(uint amount){
        require(msg.value >= amount, "not enough Ether provided!");
        _;
    }
    
    
    receive() external payable onlyWhileVacant costs(2 ether){
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
    
}
