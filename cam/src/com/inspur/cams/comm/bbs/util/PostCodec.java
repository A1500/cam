package com.inspur.cams.comm.bbs.util;

import java.io.UnsupportedEncodingException;

public class PostCodec {

	private final static String CODEC_TABLE = "abcdefghijklmnopqrstuvwxyz234567";

	public final static int FIVE_BIT = 5;

	public final static int EIGHT_BIT = 8;

	public final static int BINARY = 2;

	public static String encode(String keys) {

		return encode(keys, null);

	}

	public static String encode(String keys, String characterSet) {

		if (keys == null || "".equals(keys)) {
			return "";
		}

		byte[] keyBytes = null;

		if (characterSet == null || characterSet.length() < 1) {

			keyBytes = keys.getBytes();

		} else {

			try {

				keyBytes = keys.getBytes(characterSet);

			} catch (UnsupportedEncodingException e) {
				// ignore...
			}

		}
		return encode(keyBytes);
	}

	private static String encode(byte[] keyBytes) {

		if (keyBytes == null || keyBytes.length < 1) {

			return "";

		}


		StringBuilder mergrd = new StringBuilder();

		for (int i = 0; i < keyBytes.length; i++) {

			PostFormatUtil.formatBinary(keyBytes[i], mergrd);

		}


		int groupCount = mergrd.length() / FIVE_BIT;

		int lastCount = mergrd.length() % FIVE_BIT;

		if (lastCount > 0) {

			groupCount += 1;

		}


		StringBuilder sbEncoded = new StringBuilder();

		int forMax = groupCount * FIVE_BIT;

		for (int i = 0; i < forMax; i += FIVE_BIT) {

			int end = i + FIVE_BIT;


			boolean flag = false;

			if (end > mergrd.length()) {


				end = (i + lastCount);

				flag = true;

			}

			String strFiveBit = mergrd.substring(i, end);

			int intFiveBit = Integer.parseInt(strFiveBit, BINARY);

			if (flag) {


				intFiveBit <<= (FIVE_BIT - lastCount);

			}

			sbEncoded.append(CODEC_TABLE.charAt(intFiveBit));

		}

		return sbEncoded.toString();

	}

	public static String decode(String code) {

		return decode(code, null);

	}

	public static String decode(String code, String characterSet) {

		if (code == null || code.length() < 1) {

			return "";

		}


		StringBuilder sbBinarys = new StringBuilder();

		for (int i = 0; i < code.length(); i++) {

			int index = getCodecTableIndex(code.charAt(i));

			String indexBinary = Integer.toBinaryString(index);

			PostFormatUtil.formatBinary(indexBinary, sbBinarys, FIVE_BIT);

		}


		byte[] binarys = new byte[sbBinarys.length() / EIGHT_BIT];

		for (int i = 0, j = 0; i < binarys.length; i++) {

			String sub = sbBinarys.substring(j, j += EIGHT_BIT);

			Integer intBinary = Integer.valueOf(sub, BINARY);

			binarys[i] = intBinary.byteValue();

		}

		String decoded = null;

		if (characterSet == null || characterSet.length() < 1) {

			decoded = new String(binarys);

		} else {

			try {

				return new String(binarys, characterSet);

			} catch (UnsupportedEncodingException e) {
				// ignore...
			}
		}
		return decoded;
	}

	private static int getCodecTableIndex(char code) {

		for (int i = 0; i < CODEC_TABLE.length(); i++) {

			if (CODEC_TABLE.charAt(i) == code) {

				return i;

			}

		}

		return -1;

	}

}