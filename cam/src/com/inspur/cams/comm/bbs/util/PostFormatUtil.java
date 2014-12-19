package com.inspur.cams.comm.bbs.util;


public class PostFormatUtil {

	public static String formatBinary(byte binary) {

		return formatBinary(binary, null).toString();

	}

	public static String formatBinary(byte binary, int bitCount) {

		return formatBinary(binary, null, bitCount).toString();

	}

	public static StringBuilder formatBinary(byte binary,
			StringBuilder toAppendTo) {

		return formatBinary(binary, toAppendTo, PostCodec.EIGHT_BIT);
	}

	public static StringBuilder formatBinary(byte binary,
			StringBuilder toAppendTo, int bitCount) {

		String strBinary = Integer.toBinaryString(binary);

		return formatBinary(strBinary, toAppendTo, bitCount);
	}

	public static String formatBinary(String binary) {

		return formatBinary(binary, null).toString();

	}

	public static String formatBinary(String binary, int bitCount) {

		return formatBinary(binary, null, bitCount).toString();

	}

	public static StringBuilder formatBinary(String binary,
			StringBuilder toAppendTo) {

		return formatBinary(binary, toAppendTo, PostCodec.EIGHT_BIT);

	}

	public static StringBuilder formatBinary(String binary,
			StringBuilder toAppendTo, int bitCount) {

		if (binary == null || binary.length() < 1) {

			return toAppendTo;

		}

		if (toAppendTo == null) {

			toAppendTo = new StringBuilder();

		}

		if (binary.length() == bitCount) {

			toAppendTo.append(binary);

			return toAppendTo;

		}

		if (binary.length() < bitCount) {

			StringBuilder formatted = new StringBuilder();

			formatted.append(binary);

			do {

				formatted.insert(0, "0");

			} while (formatted.length() < bitCount);

			toAppendTo.append(formatted);

			return toAppendTo;

		}

		if (binary.length() > bitCount) {

			String intercepted = binary.substring(binary.length() - bitCount);

			toAppendTo.append(intercepted);

			return toAppendTo;

		}

		return toAppendTo;
	}

}
