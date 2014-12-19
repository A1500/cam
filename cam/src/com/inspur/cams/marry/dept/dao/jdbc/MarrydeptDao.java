package com.inspur.cams.marry.dept.dao.jdbc;

import java.util.HashMap;
import java.util.Map;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.dept.dao.IMarrydeptDao;
import com.inspur.cams.marry.dept.data.Marrydept;

/**
 * @title: MarrydeptDao
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarrydeptDao extends EntityDao<Marrydept> implements IMarrydeptDao {

	private Map CacheDept = new HashMap();

	public MarrydeptDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return Marrydept.class;
	}

	/**
	 * 获取缓存信息
	 * 
	 * @param
	 * @return
	 */
	public DataSet getCacheDept(ParameterSet pset) {
		String pid = (String) pset.get("PID@=");
		DataSet ds = null;
		if (pid != null)
			ds = (DataSet) CacheDept.get(pid);

		if (ds == null) {
			ds = query(pset);
			CacheDept.put(pid, ds);

//			System.out.println("marry_无此缓存，从数据库中获取部门:" + pid);
		} 
//		else {
//			System.out.println("marry_缓存生效，从缓存中获取部门:" + pid);
//		}
		return ds;
	}
}
