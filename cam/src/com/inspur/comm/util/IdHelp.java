package com.inspur.comm.util;

import org.loushang.persistent.id.UUIDHexGenerator;

/**
 * ID编号工具类
 * @author shgtch
 * @date 2012-3-14
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
	
}
