pragma solidity >=0.8.0 <0.9.0;

contract HotelRoom {
    
    enum Statuses{ Vacant, Occupied }
    Statuses currentStatus;
    
    event Occupy (address _occupant, uint _value);
    
    address payable public owner;
    
    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }
    
    modifier onlyWhileVacant() {
        require (currentStatus == Statuses.Vacant, "Currently occupied.");
        _;
    }
    
    modifier costs (uint _amount) {
        require (msg.value >= _amount, "Not enought Ether provided.");
        _;
    }
    
    receive() external payable onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        
        emit Occupy(msg.sender, msg.value);
    }
}
