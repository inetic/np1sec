/**
 * Multiparty Off-the-Record Messaging library
 * Copyright (C) 2014, eQualit.ie
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of version 3 of the GNU Lesser General
 * Public License as published by the Free Software Foundation.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

#include <gtest/gtest.h>
#include "src/crypt.h"


class CryptTest : public ::testing::Test { };

TEST_F(CryptTest, test_hash) {
  std::string str = "abc";
  std::string exp =
    "ba7816bf8f01cfea414140de5dae2223"
    "b00361a396177a9cb410ff61f20015ad";
  uint8_t *res = new HashBlock;
  gcry_error_t err = Hash(reinterpret_cast<const void *>(str.c_str()),
                          3, res, false);
  EXPECT_FALSE(err);
  char *buf = new char[c_hash_length*2+1];
  char *ind = buf;
  for (uint i = 0; i < c_hash_length; i++) {
    snprintf(ind, sizeof(ind), "%02x", res[i]);
    ind += 2;
  }
  ASSERT_EQ(exp, buf);
  free(buf);
  delete[] res;
}

TEST_F(CryptTest, test_encrypt) {
  Cryptic cryptic;
  ASSERT_TRUE(cryptic.init());
  std::string test_text = "This is a string to be encrypted";
  std::string enc_text = cryptic.Encrypt(test_text.c_str());
  std::string dec_text = cryptic.Decrypt(enc_text);
  ASSERT_STREQ(test_text.c_str(), dec_text.c_str());
}

// TEST_F(CryptTest, test_sign) {
//   Cryptic cryptic;
//   ASSERT_TRUE(cryptic.init());
//   std::string test_text = "This is a string to be encrypted";
//   std::string sig = cryptic.Sign(test_text);
//   bool verified = cryptic.Verify(test_text, sig);
//   EXPECT_TRUE(verified);
// }
