pragma solidity ^0.5.0;

contract Election {
    //Struktura kandidata
    struct Candidate {
      uint id;
      string name;
      uint voteCount;
    }

    //Pohrana racuna koji su glasali
    mapping(address => bool) public voters;
    //Pohrana kandidata
    //Dohvati kandidata
    mapping(uint => Candidate) public candidates;
    //Brojac glasova
    uint public candidatesCount;

    //Event za glasanje
    event votedEvent (
      uint indexed _candidateId
      );

constructor() public {
      addCandidate("Miroslav Skoro");
      addCandidate("Kolinda Grabar-Kitarovic");
      addCandidate("Zoran Milanovic");
      addCandidate("Ivan Pernar");
      addCandidate("Katarina Peovic");
      
    }

    function addCandidate (string memory _name) private {
      ++ candidatesCount;
      candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
      //Provjera da glasac nije glasao
      require(!voters[msg.sender]);

      //Mora biti validan kandidat
      require(_candidateId > 0 && _candidateId <= candidatesCount);

      //Spremi glas
      voters[msg.sender] = true;

      //Azuriranje broja glasova
      candidates[_candidateId].voteCount ++;

      //Okidac na dogadaj
      emit votedEvent(_candidateId);
    }

}
