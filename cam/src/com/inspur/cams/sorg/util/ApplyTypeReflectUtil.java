package com.inspur.cams.sorg.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

import org.loushang.next.web.cmd.BaseAjaxCommand;

public class ApplyTypeReflectUtil   extends BaseAjaxCommand {

	public  void reflect(){
		String applyType = (String)getParameter("applyType");
		try {
			Class<?> reflectClass =  Class.forName("com.inspur.cams.sorg.util.ApplyType");
			Field[] field = reflectClass.getDeclaredFields();
			for(int j = 0;j<field.length;j++){
				String value = (String)invokeMethod(reflectClass,field[j].getName());
				if(value.equals(applyType)){
					String applyTypeName = (String)invokeMethod(reflectClass,field[j].getName()+"_CN");
					setReturn("applyTypeName", applyTypeName);
				}
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public   void reflectAll(){
		try {
			Class<?> reflectClass =  Class.forName("com.inspur.cams.sorg.util.ApplyType");
			Field[] field = reflectClass.getDeclaredFields();
			StringBuffer applyTypeNameStr = new StringBuffer();
			for(int j = 0;j<field.length;j++){
				String value = (String)invokeMethod(reflectClass,field[j].getName());
				String applyTypeName = (String)invokeMethod(reflectClass,field[j].getName()+"_CN");
				applyTypeNameStr.append(value);
				applyTypeNameStr.append(":");
				applyTypeNameStr.append(applyTypeName);
				if(j != field.length){
					applyTypeNameStr.append(",");
				}
			}
			setReturn("applyTypeNameStr", applyTypeNameStr.toString());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void main(String args[]){
		ApplyTypeReflectUtil ApplyTypeReflectUtil = new ApplyTypeReflectUtil();
		ApplyTypeReflectUtil.reflectAll();
	}
	/**
     * 
     * 执行某个Field的getField方法
     * 
     * @param owner 类
     * @param fieldName 类的属性名称
     * @return 
     */
    private static  String invokeMethod(Class<?> owner, String fieldName)
    {
        String value ="";
        //fieldName -> FieldName  
        String methodName = fieldName;
        Method method = null;
        try 
        {
            method = owner.getMethod("get" + methodName);
        } 
        catch (SecurityException e) 
        {

        } 
        catch (NoSuchMethodException e) 
        {
            // e.printStackTrace();
        }
        
        //invoke getMethod
        try
        {
        	value =  method.invoke(owner).toString();
        } 
        catch (Exception e)
        {
            //e.printStackTrace();
        }
		return value;
    }
}
