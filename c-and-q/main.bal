import ballerina/crypto;
import ballerina/io;

configurable string mlDsaKeystore = "../keystores/mldsa-keystore.p12";
configurable string rsaKeystore = "../keystores/rsa-keystore.p12";
configurable string mlDsaCertFile = "../keystores/mldsa-cert.pem";
configurable string rsaCertFile = "../keystores/rsa-cert.pem";
configurable string keystorePassword = ?;
configurable string alias = "alias";

function signWithMlDsa65(byte[] input) returns byte[]|error {

    crypto:KeyStore keyStore = {
        path: mlDsaKeystore,
        password: keystorePassword
    };
    crypto:PrivateKey privateKey = check crypto:decodeMlDsa65PrivateKeyFromKeyStore(keyStore, alias, keystorePassword);
    byte[] signature = check crypto:signMlDsa65(input, privateKey);
    return signature;
}

function verifyWithMlDsa65(byte[] input, byte[] signature) returns boolean|error {

    crypto:PublicKey publicKey = check crypto:decodeMlDsa65PublicKeyFromCertFile(mlDsaCertFile);
    return crypto:verifyMlDsa65Signature(input, signature, publicKey);
}

function signWithRsa(byte[] input) returns byte[]|error {

    crypto:KeyStore keyStore = {
        path: rsaKeystore,
        password: keystorePassword
    };
    byte[] data = input;
    crypto:PrivateKey privateKey = check crypto:decodeRsaPrivateKeyFromKeyStore(keyStore, alias, keystorePassword);
    byte[] signature = check crypto:signRsaSha256(data, privateKey);
    return signature;
}

function verifyWithRsa(byte[] input, byte[] signature) returns boolean|error {

    crypto:PublicKey publicKey = check crypto:decodeRsaPublicKeyFromCertFile(rsaCertFile);
    return crypto:verifyRsaSha256Signature(input, signature, publicKey);
}

public function main() returns error? {

    byte[] input = "Hello Ballerina".toBytes();

    byte[] sigMlDsa = check signWithMlDsa65(input);
    io:println("ML DSA Signature: ", sigMlDsa.toBase64());

    byte[] sigRsaMlDsa = check signWithRsa([...input, ...sigMlDsa]);
    io:println("RSA Signature: ", sigRsaMlDsa.toBase64());
    

    boolean isVerified1 = check verifyWithMlDsa65(input, sigMlDsa);
    io:println("ML DSA Signature Verification: ", isVerified1);
    
    boolean isVerified2 = check verifyWithRsa([...input, ...sigMlDsa], sigRsaMlDsa);
    io:println("RSA Signature Verification: ", isVerified2);
}
