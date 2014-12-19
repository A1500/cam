package com.inspur.cams.comm.util;

import org.loushang.next.commons.nenum.EnumService;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.dicm.DicDao;

/**
 * 枚举工具类
 * 
 * @author zhanghui
 * 
 */
public class EnumUtil {

	/**
	 * 获取枚举文件并封存为DataSet
	 * 
	 * @param enumName
	 * @return
	 */
	public static DataSet DsFormatEnum(String enumName) {
		DataSet ds = new DataSet();
		EnumService enumService = getEnumService();
		String[] stringValues = enumService.getValues(enumName);
		String[] stringNames = enumService.getDescs(enumName);
		Record record;
		for (int i = 0; i < stringValues.length; i++) {
			record = new Record();
			record.set("value", stringValues[i]);
			record.set("text", stringNames[i]);
			ds.add(record);
		}
		ds.getMetaData().setIdProperty("value");
		return ds;
	}

	/**
	 * 通过枚举文件的value获取text值
	 * @param enumValue
	 * @param enumName
	 * @return
	 */
	public static String findTextFromEnum(String enumValue, String enumName) {
		EnumService enumService = getEnumService();
		String enumText = "";
		String[] stringValues = enumService.getValues(enumName);
		String[] stringNames = enumService.getDescs(enumName);
		for (int i = 0; i < stringValues.length; i++) {
			if (stringValues[i].equals(enumValue)) {
				enumText = stringNames[i];
				break;
			}
		}
		return enumText;

	}
	
	
	/**
	 * 通过字典表获取字段值
	 * @param dic 字典表名
	 * @param value  字典表对应的value字段名称
	 * @param text	字典表对应的text字段名称
	 * @param dsValue  所要查找的代码值
	 * @return
	 */
	public static String findTextFromEnum(String dic,String value, String text, String dsValue) {
		DicDao service = getDicService();
		String enumText = "";
		ParameterSet pset = new ParameterSet();
		pset.setParameter("dic", dic);
		pset.setParameter("value", value);
		pset.setParameter("text", text);
		DataSet ds = service.getDicMapList(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			String v=(String)ds.getRecord(i).get("value");
			if(dsValue!=null&&dsValue.equals(v)){
				enumText=(String)ds.getRecord(i).get("text");
				break;
			}
		}
		return enumText;

	}
	
	
	public static DicDao getDicService() {
		DicDao dao = (DicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		return dao;
	}
	public static EnumService getEnumService() {
		return (EnumService) ScaComponentFactory.getService(EnumService.class,
				"Enum/EnumService");
	}
	
}
