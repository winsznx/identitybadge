;; IdentityBadge - Verifiable credentials
(define-constant ERR-NOT-ISSUER (err u100))
(define-constant ERR-ALREADY-ISSUED (err u101))

(define-map badges
    { holder: principal, credential-type: (buff 32) }
    { issuer: principal, issued-at: uint, revoked: bool, metadata: (string-ascii 256) }
)

(define-map issuers { issuer: principal } { is-issuer: bool })

(define-public (issue (holder principal) (credential-type (buff 32)) (metadata (string-ascii 256)))
    (begin
        (asserts! (default-to false (get is-issuer (map-get? issuers { issuer: tx-sender }))) ERR-NOT-ISSUER)
        (asserts! (is-none (map-get? badges { holder: holder, credential-type: credential-type })) ERR-ALREADY-ISSUED)
        (map-set badges { holder: holder, credential-type: credential-type } {
            issuer: tx-sender,
            issued-at: block-height,
            revoked: false,
            metadata: metadata
        })
        (ok true)
    )
)

(define-read-only (verify (holder principal) (credential-type (buff 32)))
    (match (map-get? badges { holder: holder, credential-type: credential-type })
        badge (not (get revoked badge))
        false
    )
)

(define-read-only (get-badge (holder principal) (credential-type (buff 32)))
    (map-get? badges { holder: holder, credential-type: credential-type })
)
