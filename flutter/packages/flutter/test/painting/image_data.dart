// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

const List<int> kTransparentImage = const <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
  0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
  0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
  0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
  0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
];

/// An animated GIF image with 3 1x1 pixel frames (a red, green, and blue
/// frames). The gif animates forever, and each frame has a 100ms delay.
const List<int> kAnimatedGif = const <int> [
  0x47, 0x49, 0x46, 0x38, 0x39, 0x61, 0x01, 0x00, 0x01, 0x00, 0xa1, 0x03, 0x00,
  0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0x00, 0xff, 0xff, 0xff, 0x21,
  0xff, 0x0b, 0x4e, 0x45, 0x54, 0x53, 0x43, 0x41, 0x50, 0x45, 0x32, 0x2e, 0x30,
  0x03, 0x01, 0x00, 0x00, 0x00, 0x21, 0xf9, 0x04, 0x00, 0x0a, 0x00, 0xff, 0x00,
  0x2c, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x02, 0x02, 0x4c,
  0x01, 0x00, 0x21, 0xf9, 0x04, 0x00, 0x0a, 0x00, 0xff, 0x00, 0x2c, 0x00, 0x00,
  0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x02, 0x02, 0x54, 0x01, 0x00, 0x21,
  0xf9, 0x04, 0x00, 0x0a, 0x00, 0xff, 0x00, 0x2c, 0x00, 0x00, 0x00, 0x00, 0x01,
  0x00, 0x01, 0x00, 0x00, 0x02, 0x02, 0x44, 0x01, 0x00, 0x3b,
];
