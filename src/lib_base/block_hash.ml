(**************************************************************************)
(*                                                                        *)
(*    Copyright (c) 2014 - 2018.                                          *)
(*    Dynamic Ledger Solutions, Inc. <contact@tezos.com>                  *)
(*                                                                        *)
(*    All rights reserved. No warranty, explicit or implicit, provided.   *)
(*                                                                        *)
(**************************************************************************)

include Blake2B.Make (Tezos_crypto.Base58) (struct
    let name = "Block_hash"
    let title = "A Tezos block ID"
    let b58check_prefix = Tezos_crypto.Base58.Prefix.block_hash
    let size = None
  end)

let () =
  Tezos_crypto.Base58.check_encoded_prefix b58check_encoding "B" 51
