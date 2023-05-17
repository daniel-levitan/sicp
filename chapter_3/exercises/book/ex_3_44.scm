;#lang simply-scheme

; Since the accounts are not connected and both operations should happen in only one of
; the accounts with no dependency on the other, these processes can be done separately
; and there is no need to avoid concurrency between them, so this serialization should suffice