package com.inspur.cams.comm.extuser.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.extuser.dao.IComExtOrganTypeDao;
import com.inspur.cams.comm.extuser.data.ComExtOrganType;

/**
 * 外部单位类型dao实现类
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtOrganTypeDao extends EntityDao<ComExtOrganType> implements IComExtOrganTypeDao {

	@Override
	protected Class getEntityClass() {
		return ComExtOrganType.class;
	}

	/**
	 * 获取外部单位类型
	 * @param userId
	 * @return
	 */
	public ComExtOrganType getComExtOrganType(String code) {
		return get(code);
	}
	
	/**
	 * 增加外部单位类型
	 * @param comExtUser
	 */
	public void insertComExtOrganType(ComExtOrganType comExtOrganType) {
		insert(comExtOrganType);
	}
	
	/**
	 * 更新外部单位类型
	 * @param comExtUser
	 */
	public void updateComExtOrganType(ComExtOrganType comExtOrganType) {
		update(comExtOrganType);
	}
	
	/**
	 * 删除外部单位类型
	 * @param userId
	 */
	public void deleteComExtOrganType(String code) {
		delete(code);
	}
	
	/**
	 * 查询外部单位类型
	 * @param ps
	 * @return
	 */
	public DataSet queryExtOrganType(ParameterSet ps) {
		return query(ps);
	}
	
}
