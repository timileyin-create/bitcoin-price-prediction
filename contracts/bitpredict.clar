;; BitPredict: Decentralized Bitcoin Price Prediction Market
;;
;; A trustless platform built on Stacks where users can predict 
;; Bitcoin price movements and earn rewards for correct predictions.
;;
;; The contract enables:
;;  - Creating time-locked BTC price prediction markets
;;  - Staking STX on price movement directions (up/down)
;;  - Resolving markets via a trusted oracle
;;  - Distributing rewards to winning participants

;; Error Codes
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-invalid-prediction (err u102))
(define-constant err-market-closed (err u103))
(define-constant err-already-claimed (err u104))
(define-constant err-insufficient-balance (err u105))
(define-constant err-invalid-parameter (err u106))

;; Data Variables
;; Oracle address for resolving markets
(define-data-var oracle-address principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
;; Minimum required stake (1 STX)
(define-data-var minimum-stake uint u1000000)
;; Platform fee percentage
(define-data-var fee-percentage uint u2)
;; Auto-incrementing market ID counter
(define-data-var market-counter uint u0)

;; Data Maps
;; Stores market information including stakes and status
(define-map markets
  uint ;; market-id
  {
    start-price: uint,
    end-price: uint,
    total-up-stake: uint,
    total-down-stake: uint,
    start-block: uint,
    end-block: uint,
    resolved: bool,
  }
)

;; Stores user predictions and claims status
(define-map user-predictions
  {
    market-id: uint,
    user: principal,
  }
  {
    prediction: (string-ascii 4),
    stake: uint,
    claimed: bool,
  }
)