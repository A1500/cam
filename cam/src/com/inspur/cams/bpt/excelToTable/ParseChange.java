package com.inspur.cams.bpt.excelToTable;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.bpt.excelToTable.data.ToTable;
import com.inspur.cams.bpt.excelToTable.data.ToTableChange;
import com.inspur.cams.bpt.excelToTable.data.ToTableField;

/**
 * 使用反射解析转换方法
 * @author xu lian dong
 *
 */
public class ParseChange {
	protected static final Log logger = LogFactory.getLog(BaseJdbcDao.class);
	/**
	 * 根据参数 使用反射调用转换方法
	 * @param fieldName
	 * @param fieldValue
	 * @param toTable
	 * @return
	 */
	public String[] execute(String fieldName, String fieldValue,ToTable toTable,Map enumsmap) {
		String[] reValue=new String[]{"","",""} ;
		List<ToTableField> fieldList =toTable.getFieldList();
		List<ToTableChange> changeList = new ArrayList();
		for (ToTableField field : fieldList) {//得到验证器名字
			if(field.getFieldName().equals(fieldName)){
				changeList =field.getChangeList();
			}
		}
		
		List<String> stringList = new ArrayList();//方法所需参数
		stringList.add(fieldValue);
		
		String vailClass =toTable.getChangeClass();
		try {
			Class vaildate = Class.forName(vailClass);
			Constructor cons=vaildate.getConstructor(String.class,Map.class);//获取验证类构造方法
			Object obj=cons.newInstance(fieldValue,enumsmap);//获取验证类实例
			Method[] method =vaildate.getMethods();//获取验证类方法
			
			for (ToTableChange v : changeList) {//查找并运行所需验证方法
				String name=v.getName();
				if(name!=null&&!"".equals(name)){
					String argnum=name.substring(name.indexOf("("), name.indexOf(")")+1);//用于判定参数个数
					String mname=name.substring(0, name.indexOf("("));
					Object[] args =name.substring(name.indexOf("(")+1, name.indexOf(")")).split(",");
					for (Method md : method) {
						String mdName =md.getName();
						if(mname.equals(mdName)){
							if("()".equals(argnum))
								reValue=(String[])md.invoke(obj);//调用方法返回返回值
							else
								reValue=(String[])md.invoke(obj, args);//调用方法返回返回值
						}
					}
				}
			}
			return reValue;
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("Excel_Error",e);
			return reValue;
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("Excel_Error",e);
			return reValue;
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("Excel_Error",e);
			return reValue;
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("Excel_Error",e);
			return reValue;
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("Excel_Error",e);
			return reValue;
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("Excel_Error",e);
			return reValue;
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("Excel_Error",e);
			return reValue;
		}
		
	}
	
	/**
	 * 读取枚举文件 
	 * @param enumPath
	 * @return
	 */
	public Map getEnumsMap(String enumPath){
	     Properties props = new Properties();
	     
	        try {
		         InputStream in = new BufferedInputStream (new FileInputStream(enumPath));
		         props.load(in);
	             Enumeration en = props.propertyNames();
	             
	             Map map = new HashMap();
	             while (en.hasMoreElements()) {
            	 	String key = (String) en.nextElement();
                    String Property = props.getProperty (key);
	                map.put(key, Property);    
	             }
	             return map;
	        } catch (Exception e) {
	        	e.printStackTrace();
	        	logger.error("Excel_Error",e);
	        	return null;
	        }

	}
}
