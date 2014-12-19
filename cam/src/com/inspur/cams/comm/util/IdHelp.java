package com.inspur.cams.comm.util;

import org.loushang.persistent.id.UUIDHexGenerator;

/**
 * ID编号工具类
 * @author shgtch
 * @date 2011-5-10
 */
public class IdHelp {

	/**
	 * 获取32位随机编号
	 * @return
	 */
	public static String getUUID32() {
		UUIDHexGenerator uuidHexGenerator = new UUIDHexGenerator();
        return String.valueOf(uuidHexGenerator.generate());
	}

	/**
	 * 获取30位随机编号
	 * @return
	 */
	public static String getUUID30() {
		UUIDHexGenerator uuidHexGenerator = new UUIDHexGenerator();
        String UUID32 = String.valueOf(uuidHexGenerator.generate());
        return UUID32;
	}

}
