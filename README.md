# IdentityBadge

Verifiable credentials system with issuer registry on Base and Stacks blockchains.

## Features

- Issue verifiable credentials/badges
- Authorized issuer registry
- Revoke credentials when needed
- Verify credential authenticity
- Multi-chain identity system

## Smart Contract Functions

### Base (Solidity)
- `issue(address holder, bytes32 credentialType, string metadata)` - Issue badge
- `revoke(address holder, bytes32 credentialType)` - Revoke badge
- `verify(address holder, bytes32 credentialType)` - Verify badge
- `getBadge(address holder, bytes32 credentialType)` - Get badge details
- `addIssuer(address issuer)` - Add authorized issuer

### Stacks (Clarity)
- `(issue (holder principal) (credential-type (buff 32)) (metadata (string-ascii 256)))` - Issue
- `(verify (holder principal) (credential-type (buff 32)))` - Verify
- `(get-badge (holder principal) (credential-type (buff 32)))` - Get badge

## Tech Stack

- **Frontend**: Next.js 14, TypeScript, Tailwind CSS
- **Base**: Solidity 0.8.20, Foundry, Reown wallet
- **Stacks**: Clarity v4, Clarinet, @stacks/connect

## Getting Started

```bash
pnpm install
pnpm dev
```

## License

MIT License
