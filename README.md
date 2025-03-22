# Hybrid Post-Quantum Digital Signatures with Ballerina

This repository demonstrates the implementation of **Hybrid Post-Quantum Digital Signatures** using **Ballerina**. The code explores two hybrid signature approaches: **Parallel Hybrid** and **Nested Hybrid**, with **ML-DSA** and **RSA** used as example algorithms. These approaches combine classical cryptography and post-quantum cryptography to ensure security against both classical and quantum threats.

## Table of Contents
1. [Overview](#overview)
2. [Repository Structure](#repository-structure)
3. [Code Implementation](#code-implementation)
   - [c-and-q - Nested Hybrid Signature](#c-and-q---nested-hybrid-signature)
   - [c-plus-q - Parallel Hybrid Signature](#c-plus-q---parallel-hybrid-signature)
4. [Keystores and Certificates](#keystores-and-certificates)
5. [Running the Code](#running-the-code)

## Overview

As quantum computers become a reality, traditional cryptographic algorithms, like **RSA** and **ECDSA**, face potential vulnerabilities to quantum-based attacks. **Post-Quantum Cryptography** (PQC) offers new algorithms, such as **ML-DSA** (Multi-Level Digital Signature Algorithm), designed to resist these quantum threats. However, PQC algorithms are still evolving and are not yet widely adopted. Hybrid cryptographic techniques combine **classical** algorithms with **post-quantum** algorithms to offer a seamless transition towards quantum-resistant security.

In this repository, we implement and demonstrate how Ballerina can be used to implement **Hybrid Post-Quantum Digital Signatures** with **RSA** and **ML-DSA** in two distinct approaches:
1. **Parallel Hybrid Signatures**
2. **Nested Hybrid Signatures**

Both approaches are covered in separate folders with their respective code examples.

## Repository Structure

The repository is organized into three folders:

- **`keystores/`**: Contains the **RSA** and **ML-DSA** keystores and certificates.
- **`c-and-q/`**: Contains the Ballerina code for **Nested Hybrid Signing and Verification** (ML-DSA first, followed by RSA).
- **`c-plus-q/`**: Contains the Ballerina code for **Parallel Hybrid Signing and Verification** (separate RSA and ML-DSA signatures).

## Code Implementation

### c-and-q - Nested Hybrid Signature

The **`c-and-q/`** folder contains the implementation for **Nested Hybrid Signing and Verification**. In this approach, the message is first signed using **ML-DSA**, and the resulting **ML-DSA** signature is signed using **RSA**.

- **Signing Flow**: The original message is signed with **ML-DSA**, and then the **ML-DSA** signature is signed again using **RSA** to create the final hybrid signature.
- **Verification Flow**: The RSA signature is verified first, followed by the **ML-DSA** signature.

### c-plus-q - Parallel Hybrid Signature

The **`c-plus-q/`** folder contains the implementation for **Parallel Hybrid Signing and Verification**. In this approach, the message is signed separately using both **ML-DSA** and **RSA**, and both signatures are combined into a final hybrid signature.

- **Signing Flow**: The original message is signed with **ML-DSA** and **RSA** independently. Both signatures are then combined to form the hybrid signature.
- **Verification Flow**: Each signature (**ML-DSA** and **RSA**) is verified independently.

## Keystores and Certificates

The **`keystores/`** folder contains the keystores and certificates needed for both **RSA** and **ML-DSA** signing and verification. These keystores include private keys, certificates, and other necessary cryptographic material for performing the hybrid signature operations.

Make sure to refer to the keystores for the required certificates when running the code.

## Running the Code

To run the code locally, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/hwupathum/ballerina-post-quantum-signatures-demo.git
    cd ballerina-post-quantum-signatures-demo
    ```

2. Ensure you have Ballerina Swan Lake Update 12 installed. You can download it from the [Ballerina website](https://ballerina.io/).

3. Navigate to the appropriate folder (`c-and-q` for nested hybrid or `c-plus-q` for parallel hybrid) and run the Ballerina program:
    ```bash
    bal run
    ```

4. Check the output for the result of signing and verification using the selected hybrid signature method.

