// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title IdentityBadge
 * @notice Verifiable credentials with issuer registry
 */
contract IdentityBadge {
    error NotIssuer();
    error AlreadyIssued();
    error Revoked();

    event BadgeIssued(address indexed holder, bytes32 indexed credentialType, address indexed issuer);
    event BadgeRevoked(address indexed holder, bytes32 indexed credentialType);

    struct Badge {
        address issuer;
        uint256 issuedAt;
        bool revoked;
        string metadata;
    }

    mapping(address => mapping(bytes32 => Badge)) public badges;
    mapping(address => bool) public issuers;

    constructor() {
        issuers[msg.sender] = true;
    }

    function issue(address holder, bytes32 credentialType, string calldata metadata) external {
        if (!issuers[msg.sender]) revert NotIssuer();
        if (badges[holder][credentialType].issuer != address(0)) revert AlreadyIssued();
        
        badges[holder][credentialType] = Badge({
            issuer: msg.sender,
            issuedAt: block.timestamp,
            revoked: false,
            metadata: metadata
        });
        
        emit BadgeIssued(holder, credentialType, msg.sender);
    }

    function revoke(address holder, bytes32 credentialType) external {
        if (badges[holder][credentialType].issuer != msg.sender) revert NotIssuer();
        badges[holder][credentialType].revoked = true;
        emit BadgeRevoked(holder, credentialType);
    }

    function verify(address holder, bytes32 credentialType) external view returns (bool) {
        Badge memory badge = badges[holder][credentialType];
        return badge.issuer != address(0) && !badge.revoked;
    }

    function getBadge(address holder, bytes32 credentialType) external view returns (address, uint256, bool, string memory) {
        Badge memory badge = badges[holder][credentialType];
        return (badge.issuer, badge.issuedAt, badge.revoked, badge.metadata);
    }

    function addIssuer(address issuer) external {
        require(issuers[msg.sender]);
        issuers[issuer] = true;
    }
}
