package com.inspur.cams.comm.informUtil;


/**
 * ��ʽ��������
 *
 * @author gembler
 * @version 2008-12-3 ����03:01:50
 */
public class InformFormatUtil {

	public static String formatBinary(byte binary) {

		return formatBinary(binary, null).toString();

	}

	/**
	 * ��ʽ�������ƣ��������ȡ���������㡣��ʽ����00000000������NumberFormat��pattern����########�����ơ�
	 *
	 * @author gembler
	 * @version 2008-12-3 ����03:15:09
	 *
	 * @param binary
	 *            ��Ҫ��ʽ�����ֽڡ�
	 * @param bitCount
	 *            ��Ҫ��ʽ����λ��
	 *
	 * @return ��ʽ������ַ�
	 */
	public static String formatBinary(byte binary, int bitCount) {

		return formatBinary(binary, null, bitCount).toString();

	}

	/**
	 * ��ʽ�������ƣ��������ȡ���������㡣��ʽ����00000000������NumberFormat��pattern����########�����ơ�
	 *
	 * @author gembler
	 * @version 2008-12-3 ����03:15:12
	 *
	 * @param binary
	 *            ��Ҫ��ʽ�����ֽڡ�
	 * @param toAppendTo
	 *            ׷�ӵ���Builder��
	 *
	 * @return ��ʽ�����StringBuilder��
	 */
	public static StringBuilder formatBinary(byte binary,
			StringBuilder toAppendTo) {

		return formatBinary(binary, toAppendTo, InformCodec.EIGHT_BIT);
	}

	/**
	 * ��ʽ�������ƣ��������ȡ���������㡣��ʽ����00000000������NumberFormat��pattern����########�����ơ�
	 *
	 * @author gembler
	 * @version 2008-12-3 ����03:15:16
	 *
	 * @param binary
	 *            ��Ҫ��ʽ�����ֽڡ�
	 * @param toAppendTo
	 *            ׷�ӵ���Builder��
	 * @param bitCount
	 *            ��Ҫ��ʽ����λ��
	 *
	 * @return ��ʽ�����StringBuilder��
	 */
	public static StringBuilder formatBinary(byte binary,
			StringBuilder toAppendTo, int bitCount) {

		String strBinary = Integer.toBinaryString(binary);

		return formatBinary(strBinary, toAppendTo, bitCount);
	}

	/**
	 * ��ʽ�������ƣ��������ȡ���������㡣��ʽ����00000000������NumberFormat��pattern����########�����ơ�
	 *
	 * @author gembler
	 * @version 2008-12-3 ����03:15:20
	 *
	 * @param binary
	 *            ��Ҫ��ʽ�����ֽڡ�
	 *
	 * @return ��ʽ������ַ�
	 */
	public static String formatBinary(String binary) {

		return formatBinary(binary, null).toString();

	}

	/**
	 * ��ʽ�������ƣ��������ȡ���������㡣��ʽ����00000000������NumberFormat��pattern����########�����ơ�
	 *
	 * @author gembler
	 * @version 2008-12-3 ����03:15:24
	 *
	 * @param binary
	 *            ��Ҫ��ʽ�����ֽڡ�
	 * @param bitCount
	 *            ��Ҫ��ʽ����λ��
	 *
	 * @return ��ʽ������ַ�
	 */
	public static String formatBinary(String binary, int bitCount) {

		return formatBinary(binary, null, bitCount).toString();

	}

	/**
	 * ��ʽ�������ƣ��������ȡ���������㡣��ʽ����00000000������NumberFormat��pattern����########�����ơ�
	 *
	 * @author gembler
	 * @version 2008-12-3 ����03:15:27
	 *
	 * @param binary
	 *            ��Ҫ��ʽ�����ֽڡ�
	 * @param toAppendTo
	 *            ׷�ӵ���Builder��
	 *
	 * @return ��ʽ�����StringBuilder��
	 */
	public static StringBuilder formatBinary(String binary,
			StringBuilder toAppendTo) {

		return formatBinary(binary, toAppendTo, InformCodec.EIGHT_BIT);

	}

	/**
	 * ��ʽ�������ƣ��������ȡ���������㡣��ʽ����00000000������NumberFormat��pattern����########�����ơ�
	 *
	 * @author gembler
	 * @version 2008-12-3 ����03:15:31
	 *
	 * @param binary
	 *            ��Ҫ��ʽ�����ֽڡ�
	 * @param toAppendTo
	 *            ׷�ӵ���Builder��
	 * @param bitCount
	 *            ׷�ӵ���Builder��
	 *
	 * @return ��ʽ�����StringBuilder��
	 */
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

		/*
		 * ǰ��0�� �磺 "100011" to "00100011"
		 */
		if (binary.length() < bitCount) {

			StringBuilder formatted = new StringBuilder();

			formatted.append(binary);

			do {

				formatted.insert(0, "0");

			} while (formatted.length() < bitCount);

			toAppendTo.append(formatted);

			return toAppendTo;

		}

		/*
		 * ��ȡ�� �磺 "11111111111111111111111110100011" to "10100011"
		 */
		if (binary.length() > bitCount) {

			String intercepted = binary.substring(binary.length() - bitCount);

			toAppendTo.append(intercepted);

			return toAppendTo;

		}

		return toAppendTo;
	}

}
