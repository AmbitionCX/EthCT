// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract EthCT {
    error CertificateExists();
    error NoDataExists();

    struct Certificate {
        string candidate_name;
        string org_name;
        string course_name;
        uint256 expiration_date;
    }

    mapping(bytes32 => Certificate) public certificates;

    event CertificateGenerated(bytes32 indexed certificateId);

    function stringToBytes32(string memory source) private pure returns (bytes32 result) {
        bytes memory temp = bytes(source);
        if (temp.length == 0) {
            return 0x0;
        } else if (temp.length > 32) {
            revert("String too long");
        } else {
            assembly {
                result := mload(add(source, 32))
            }
        }
    }

    function generateCertificate(
        string memory _id,
        string memory _candidate_name,
        string memory _org_name,
        string memory _course_name,
        uint256 _expiration_date
    ) public {
        bytes32 byteId = stringToBytes32(_id);
        if (certificates[byteId].expiration_date != 0) {
            revert CertificateExists();
        }
        certificates[byteId] = Certificate(_candidate_name, _org_name, _course_name, _expiration_date);
        emit CertificateGenerated(byteId);
    }

    function getData(string memory _id) public view returns(string memory, string memory, string memory, uint256) {
        bytes32 byteId = stringToBytes32(_id);
        Certificate memory temp = certificates[byteId];
        if (temp.expiration_date == 0) {
            revert NoDataExists();
        }
        return (temp.candidate_name, temp.org_name, temp.course_name, temp.expiration_date);
    }
}
