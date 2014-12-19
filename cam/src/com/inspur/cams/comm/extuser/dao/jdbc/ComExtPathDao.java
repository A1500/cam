package com.inspur.cams.comm.extuser.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.extuser.dao.IComExtPathDao;
import com.inspur.cams.comm.extuser.data.ComExtPath;

/**
 * 扩展页面路径配置dao实现类
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtPathDao extends EntityDao<ComExtPath> implements IComExtPathDao {

	@Override
	protected Class getEntityClass() {
		return ComExtPath.class;
	}

	/**
	 * 获取扩展页面路径配置
	 * @param userId
	 * @return
	 */
	public ComExtPath getComExtPath(String extPath) {
		return get(extPath);
	}
	
	/**
	 * 增加扩展页面路径配置
	 * @param comExtUser
	 */
	public void insertComExtPath(ComExtPath comExtPath) {
		insert(comExtPath);
	}
	
	/**
	 * 更新扩展页面路径配置
	 * @param comExtUser
	 */
	public void updateComExtPath(ComExtPath comExtPath) {
		update(comExtPath);
	}
	
	/**
	 * 删除扩展页面路径配置
	 * @param userId
	 */
	public void deleteComExtPath(String extPath) {
		delete(extPath);
	}
	
	/**
	 * 查询扩展页面路径配置
	 * @param ps
	 * @return
	 */
	public DataSet queryExtPath(ParameterSet ps) {
		return query(ps);
	}
	
}
