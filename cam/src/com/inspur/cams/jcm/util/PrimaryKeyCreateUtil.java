package com.inspur.cams.jcm.util;

import java.util.UUID;
/**
 * 主键生成器
 * @author zhenSenSen
 *
 */
public final class PrimaryKeyCreateUtil {
	/**
	 * 生成主键
	 * @return
	 */
	public final static String createPrimaryKey(){
		return UUID.randomUUID().toString().replace("-", "");
	}
}
