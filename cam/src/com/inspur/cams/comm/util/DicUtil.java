package com.inspur.cams.comm.util;

import org.loushang.next.dao.DaoFactory;

import com.inspur.cams.comm.dicm.DicDao;

/**
 * 字典表查询类
 * @author yanliangliang
 * @date  2012年5月29日
 */
public class DicUtil {
	/**
	 * 通过字典表特定字段的值，获取指定字段的值
	 * @param dic 表名
	 * @param PrimaryKey  特定字段的名称
 	 * @param PrimaryKeyValue 特定字段的值
	 * @param queryField	指定字段的名称
	 * @return 指定字段的值
	 */
	public static String getTextValueFromDic(String dic,String PrimaryKey,String PrimaryKeyValue,String queryField){
		DicDao service = getDicService();
		return service.getTextValueFromDic(dic,PrimaryKey,PrimaryKeyValue,queryField);
	}
	public static DicDao getDicService() {
		DicDao dao = (DicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		return dao;
	}
}
