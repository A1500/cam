package com.inspur.cams.comm.print.dao;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * 打印dao接口
 * 
 * @author zhanghui
 * 
 */
public abstract class IPrintDao extends EntityDao {

	/**
	 * 查询要打印的数据
	 * 
	 * @param pset
	 * @return
	 */
	public abstract DataSet queryData(ParameterSet pset);

	/**
	 * 动态的调用执行的方法
	 * 
	 * @param dao
	 * @param pst
	 * @return
	 */
	public DataSet execute(Object obj, ParameterSet pst) {
		DataSet ds = new DataSet();
		String method = (String) pst.getParameter("method");
		if (method == null || "".equals(method)) {
			method = "queryData";
		}

		try {
			Method daoMethod = obj.getClass().getDeclaredMethod(method, ParameterSet.class);
			ds = (DataSet) daoMethod.invoke(obj, pst);
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return ds;
	}
}
