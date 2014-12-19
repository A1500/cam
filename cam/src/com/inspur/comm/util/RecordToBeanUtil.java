package com.inspur.comm.util;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.Field;
import org.loushang.next.data.FieldSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;


/**
 * @Description: TODO 将通过sql查出来的record转换成Bean
 * @author luguosui
 * @date 2011-11-30
 */
public class RecordToBeanUtil {
	/**
	 * 通用的Record转换成Bean
	 * @author mq
	 * @param record
	 * @param class1
	 * @return
	 */
	public static Object recordToBeanUtil(Record record,Class class1){
		try {
			if(class1!=null&&record!=null){
				Object obj = class1.newInstance();
				Method[] m = class1.getMethods();
				Iterator<String> it = record.keys();
				String methodName = new String();
				while(it.hasNext()){
					String key = it.next();
					String[] keyArr = key.split("_");
					for (int i = 0; i < keyArr.length; i++) {
						if(i==0){
							if(keyArr[i].length()>1){
								methodName = "set"+keyArr[i].substring(0, 1)+keyArr[i].substring(1).toLowerCase(Locale.ENGLISH);
							}else if(keyArr[i].length()==1){
								methodName = "set"+keyArr[i].substring(0, 1);
							}
						}else{
							if(keyArr[i].length()>1){
								methodName = methodName+keyArr[i].substring(0,1)+keyArr[i].substring(1).toLowerCase(Locale.ENGLISH);
							}else if(keyArr[i].length()==1){
								methodName = methodName+keyArr[i].substring(0,1);
							}
						}
					}
					for (Method method : m) {
						if(method.getName().endsWith(methodName)){
							method.invoke(obj, new Object[]{record.get(key)});
							break;
						}
					}
				}
				return obj;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return null;
	}
	
	/**
	 * 通用的将DataSet中的FieldSet和RecordSet对应大写字段改为小写字段
	 * @author mq
	 * @param ds
	 * @return
	 */
	public static DataSet uppercaseToLowercase(DataSet ds){
		if(ds!=null&&ds.getCount()>0){
			FieldSet fs = new FieldSet();
			RecordSet rs = new RecordSet();
			Map<String, Object> map = new HashMap<String, Object>();
			map.putAll(ds.getRecord(0).getData());
			Iterator<String> it = map.keySet().iterator();
			while(it.hasNext()){
				String key = it.next();
				String keyFormat = new String("");
				String[] keyArr = key.split("_");
				for (int i = 0; i < keyArr.length; i++) {
					if(i==0){
						keyFormat = keyFormat+keyArr[i].toLowerCase(Locale.ENGLISH);
					}else{
						if(keyArr[i].length()>1){
							keyFormat = keyFormat+keyArr[i].substring(0,1)+keyArr[i].substring(1).toLowerCase(Locale.ENGLISH);
						}else if(keyArr[i].length()==1){
							keyFormat = keyFormat+keyArr[i].substring(0,1);
						}
					}
				}
				Field field = new Field();
				field.setName(keyFormat);
				fs.add(field);
				
				for (int i = 0; i < ds.getCount(); i++) {
					Record recordFormat = ds.getRecord(i);
					recordFormat.set(keyFormat, recordFormat.get(key));
					recordFormat.getData().remove(key);
				}
			}
			ds.setFieldSet(fs);
		}
		return ds ;
	}
}
