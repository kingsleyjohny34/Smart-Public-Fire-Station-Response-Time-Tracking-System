;; Call Dispatch Contract
;; Records emergency call reception and response initiation

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INVALID-CALL-ID (err u101))
(define-constant ERR-CALL-ALREADY-EXISTS (err u102))
(define-constant ERR-INVALID-PRIORITY (err u103))
(define-constant ERR-CALL-NOT-FOUND (err u104))

;; Data Variables
(define-data-var next-call-id uint u1)
(define-data-var total-calls uint u0)

;; Data Maps
(define-map emergency-calls
  { call-id: uint }
  {
    caller-address: (string-ascii 100),
    incident-type: (string-ascii 50),
    priority-level: uint,
    location: (string-ascii 200),
    call-received-time: uint,
    dispatch-time: (optional uint),
    responding-units: (list 5 uint),
    status: (string-ascii 20),
    notes: (string-ascii 500)
  }
)

(define-map call-statistics
  { date: uint }
  {
    total-calls: uint,
    high-priority: uint,
    medium-priority: uint,
    low-priority: uint,
    average-dispatch-time: uint
  }
)

;; Private Functions
(define-private (is-valid-priority (priority uint))
  (and (>= priority u1) (<= priority u5))
)

(define-private (get-current-timestamp)
  block-height
)

;; Public Functions
(define-public (record-emergency-call
  (caller-address (string-ascii 100))
  (incident-type (string-ascii 50))
  (priority-level uint)
  (location (string-ascii 200))
  (notes (string-ascii 500)))
  (let
    (
      (call-id (var-get next-call-id))
      (current-time (get-current-timestamp))
    )
    (asserts! (is-valid-priority priority-level) ERR-INVALID-PRIORITY)
    (asserts! (is-none (map-get? emergency-calls { call-id: call-id })) ERR-CALL-ALREADY-EXISTS)

    (map-set emergency-calls
      { call-id: call-id }
      {
        caller-address: caller-address,
        incident-type: incident-type,
        priority-level: priority-level,
        location: location,
        call-received-time: current-time,
        dispatch-time: none,
        responding-units: (list),
        status: "received",
        notes: notes
      }
    )

    (var-set next-call-id (+ call-id u1))
    (var-set total-calls (+ (var-get total-calls) u1))

    (ok call-id)
  )
)

(define-public (dispatch-units
  (call-id uint)
  (unit-ids (list 5 uint)))
  (let
    (
      (call-data (unwrap! (map-get? emergency-calls { call-id: call-id }) ERR-CALL-NOT-FOUND))
      (current-time (get-current-timestamp))
    )
    (map-set emergency-calls
      { call-id: call-id }
      (merge call-data {
        dispatch-time: (some current-time),
        responding-units: unit-ids,
        status: "dispatched"
      })
    )

    (ok true)
  )
)

(define-public (update-call-status
  (call-id uint)
  (new-status (string-ascii 20)))
  (let
    (
      (call-data (unwrap! (map-get? emergency-calls { call-id: call-id }) ERR-CALL-NOT-FOUND))
    )
    (map-set emergency-calls
      { call-id: call-id }
      (merge call-data { status: new-status })
    )

    (ok true)
  )
)

;; Read-only Functions
(define-read-only (get-call-details (call-id uint))
  (map-get? emergency-calls { call-id: call-id })
)

(define-read-only (get-total-calls)
  (var-get total-calls)
)

(define-read-only (get-next-call-id)
  (var-get next-call-id)
)

(define-read-only (get-calls-by-priority (priority uint))
  (filter get-calls-with-priority (list u1 u2 u3 u4 u5 u6 u7 u8 u9 u10))
)

(define-private (get-calls-with-priority (call-id uint))
  (match (map-get? emergency-calls { call-id: call-id })
    call-data (>= (get priority-level call-data) u4)
    false
  )
)

(define-read-only (calculate-dispatch-time (call-id uint))
  (match (map-get? emergency-calls { call-id: call-id })
    call-data
      (match (get dispatch-time call-data)
        dispatch-time (some (- dispatch-time (get call-received-time call-data)))
        none
      )
    none
  )
)

(define-read-only (get-high-priority-calls)
  (filter is-high-priority-call (list u1 u2 u3 u4 u5 u6 u7 u8 u9 u10))
)

(define-private (is-high-priority-call (call-id uint))
  (match (map-get? emergency-calls { call-id: call-id })
    call-data (>= (get priority-level call-data) u4)
    false
  )
)

(define-read-only (get-active-calls)
  (filter is-active-call (list u1 u2 u3 u4 u5 u6 u7 u8 u9 u10))
)

(define-private (is-active-call (call-id uint))
  (match (map-get? emergency-calls { call-id: call-id })
    call-data (not (is-eq (get status call-data) "completed"))
    false
  )
)
