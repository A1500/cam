package com.inspur.cams.bpt.util;

import java.util.Iterator;

import org.loushang.next.data.Record;

/**
 *    功能：字段大小写转换
 * 应用范围：限于类似 PEOPLE_ID 转换为 peopleId,用于sql查询DataSet后进行封装
 */
public class FieldCaseChange {
	
	@SuppressWarnings("unchecked")
	public static void formatRecord(Record returnRecord, Record record) {
		Iterator<String> iterator = (Iterator<String>)record.keys();
		String key;
		while(iterator.hasNext()){
			key = iterator.next();
			returnRecord.set(formatModelName(key), record.get(key));
		}
		iterator = null;
	}
	
	private static String formatModelName(String str) {
		str = str.toLowerCase();
		if (str.indexOf("_") != -1) {
			String[] strs = str.split("_");
			str = strs[0];
			for (int i = 1; i < strs.length; i++) {
				str += strs[i].replaceFirst(strs[i].substring(0, 1), strs[i].substring(0, 1).toUpperCase());
			}
		}
		return str;
	}
}
