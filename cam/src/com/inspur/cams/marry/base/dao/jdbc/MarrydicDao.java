package com.inspur.cams.marry.base.dao.jdbc;

import java.util.HashMap;
import java.util.Map;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.dao.IMarrydicDao;
import com.inspur.cams.marry.base.data.Marrydic;

/**
 * @title:MarrydicDao
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarrydicDao extends EntityDao<Marrydic> implements IMarrydicDao {

	private Map CacheDic = new HashMap();
	
	public MarrydicDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return Marrydic.class;
	}
	
	/**
	 * 获取缓存信息
	 * @param
	 * @return
	 */
	public DataSet getCacheDic(ParameterSet ps) {
		String pid = (String)ps.get("PID@=");
		
		DataSet ds = (DataSet) CacheDic.get(pid);
		if (ds == null) {
			ds = query(ps);
			CacheDic.put(pid, ds);
			
//			System.out.println("marry_无此缓存，从数据库中获取字典:" + pid);
		}
//		else{
//			System.out.println("marry_缓存生效，从缓存中获取字典:" + pid);
//		}
		return ds;
	}
}
