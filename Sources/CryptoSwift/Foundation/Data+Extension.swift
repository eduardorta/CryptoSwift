//
//  PGPDataExtension.swift
//  SwiftPGP
//
//  Created by Marcin Krzyzanowski on 05/07/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//

import Foundation

extension Data {

    /// Two octet checksum as defined in RFC-4880. Sum of all octets, mod 65536
    public func checksum() -> UInt16 {
        var s: UInt32 = 0
        var bytesArray = self.bytes
        for i in 0 ..< bytesArray.count {
            s = s + UInt32(bytesArray[i])
        }
        s = s % 65536
        return UInt16(s)
    }

    public func md5() -> Data {
        return Data(bytes: Digest.md5(self.bytes))
    }

    public func sha1() -> Data {
        return Data(bytes: Digest.sha1(self.bytes))
    }

    public func sha224() -> Data {
        return Data(bytes: Digest.sha224(self.bytes))
    }

    public func sha256() -> Data {
        return Data(bytes: Digest.sha256(self.bytes))
    }

    public func sha384() -> Data {
        return Data(bytes: Digest.sha384(self.bytes))
    }

    public func sha512() -> Data {
        return Data(bytes: Digest.sha512(self.bytes))
    }

    public func sha3(_ variant: SHA3.Variant) -> Data {
        return Data(bytes: Digest.sha3(self.bytes, variant: variant))
    }

    public func crc32(seed: UInt32? = nil, reflect: Bool = true) -> Data {
        return Data(bytes: Checksum.crc32(self.bytes, seed: seed, reflect: reflect).bytes())
    }

    public func crc16(seed: UInt16? = nil) -> Data {
        return Data(bytes: Checksum.crc16(self.bytes, seed: seed).bytes())
    }

    public func encrypt(cipher: Cipher) throws -> Data {
        return Data(bytes: try cipher.encrypt(self.bytes))
    }

    public func decrypt(cipher: Cipher) throws -> Data {
        return Data(bytes: try cipher.decrypt(self.bytes))
    }

    public func authenticate(with authenticator: Authenticator) throws -> Data {
        return Data(bytes: try authenticator.authenticate(self.bytes))
    }
}

extension Data {

    public var bytes: Array<UInt8> {
        return Array(self)
    }

    public func toHexString() -> String {
        return self.bytes.toHexString()
    }
}
