package com.inspur.cams.bpt.excelToTable;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.bpt.excelToTable.data.FieldValidate;
import com.inspur.cams.bpt.excelToTable.data.ToTable;
import com.inspur.cams.bpt.excelToTable.data.ToTableField;

/**
 * 使用反射解析验证方法
 * @author xu lian dong
 *
 */
public class ParseValidate {
	protected static final Log logger = LogFactory.getLog(BaseJdbcDao.class);
	/**
	 * 根据参数 使用反射解析验证方法
	 * @param fieldName
	 * @param fieldValue
	 * @param toTable
	 * @return
	 */
	public String[] execute(String fieldName, String fieldValue,ToTable toTable) {
		String[] reValue=new String[2] ;
		List<ToTableField> fieldList =toTable.getFieldList();
		List<FieldValidate> vailList = new ArrayList();
		for (ToTableField field : fieldList) {//得到验证器名字
			if(field.getFieldName().equals(fieldName)){
				vailList =field.getFieldValiList();
			}
		}
		
		List<String> stringList = new ArrayList();//方法所需参数
		stringList.add(fieldValue);
		
		String vailClass =toTable.getVailClass();
		try {
			Class vaildate = Class.forName(vailClass);
			Constructor cons=vaildate.getConstructor(String.class);//获取验证类构造方法
			Object obj=cons.newInstance(fieldValue);//获取验证类实例
			Method[] method =vaildate.getMethods();//获取验证类方法
			//Method[] method =vaildate.getDeclaredMethods();//获取验证类方法
			
			for (FieldValidate v : vailList) {//查找并运行所需验证方法
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
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return reValue;
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return reValue;
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return reValue;
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return reValue;
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return reValue;
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return reValue;
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			logger.error("Excel_Error",e);
			e.printStackTrace();
			return reValue;
		}
		
	}
	
	/**
	 * 数据验证
	 * 
	 * @param fieldValue
	 * @param v_methods
	 * @param validateClass
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static String[] validateMark(String fieldValue,
			List<FieldValidate> v_methods, String validateClass)
			throws Exception {
		String[] validateResult = new String[2];
		Class validate = Class.forName(validateClass);
		Constructor cons = validate.getConstructor(String.class);// 获取验证类构造方法
		if (cons != null) {
			Object obj = cons.newInstance(fieldValue);// 获取验证类实例
			if(v_methods.size() == 0) {
				validateResult[0]="0";
			} else {
				for (FieldValidate f_validate : v_methods) {
					String[] result = getMarkInfo(validate, f_validate.getName(), obj);
					if("1".equals(result[0])) {
						validateResult[0]="1"; //验证不通过，无需做下一步验证
						validateResult[1]=result[1];
						break;
					} else if("0".equals(result[0])) {
						validateResult[0]="0"; //验证通过，继续下一个验证
						continue;
					}
				}
			}
		}
		return validateResult;
	}

	/**
	 * 获得验证信息
	 * 
	 * @param validate_method
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String[] getMarkInfo(Class validate, String validate_method,
			Object obj) throws Exception {
		String[] result;
		int count = 0;//方法参数数目
		int left = validate_method.indexOf("(");//获取方法左"("
		int right = validate_method.indexOf(")");//获取方法右"("
		String method = validate_method.substring(0, left);//获取方法名
		Object[] objs = null;
		Class[] args;
		if (right - left > 1) { //方法有参数
			String param = validate_method.substring(left + 1, right);
			if (param.indexOf(",") != -1) {
				objs = param.split(",");
				count = objs.length;
			} else {
				count = 1;
				objs = new Object[1];
				objs[0]= param;
			}
		}
		if (count == 0) { //无参方法
			result = (String[]) validate.getMethod(method, null).invoke(obj,
					null);
		} else {//有参方法
			args = new Class[count];
			for(int i=0;i<args.length;i++) {
				args[i]=String.class;
			}
			result = (String[]) validate.getMethod(method, args).invoke(obj,
					objs);
		}
		return result;
	}
}
