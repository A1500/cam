package com.inspur.cams.comm.extuser.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.extuser.dao.IComExtOrganDao;
import com.inspur.cams.comm.extuser.data.ComExtOrgan;

/**
 * 外部单位dao实现类
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtOrganDao extends EntityDao<ComExtOrgan> implements IComExtOrganDao {

	// 逻辑删除单位信息
	public static String DELETE_BY_ORGAN_ID = "UPDATE COM_EXT_ORGAN SET IN_USE='0' WHERE ORGAN_ID=?";
	
	@Override
	protected Class getEntityClass() {
		return ComExtOrgan.class;
	}

	/**
	 * 获取外部单位信息
	 * @param userId
	 * @return
	 */
	public ComExtOrgan getComExtOrgan(String organId) {
		return get(organId);
	}
	
	/**
	 * 增加外部单位信息
	 * @param comExtUser
	 */
	public void insertComExtOrgan(ComExtOrgan comExtOrgan) {
		insert(comExtOrgan);
	}
	
	/**
	 * 更新外部单位信息
	 * @param comExtUser
	 */
	public void updateComExtOrgan(ComExtOrgan comExtOrgan) {
		update(comExtOrgan);
	}
	
	/**
	 * 逻辑删除外部单位信息
	 * @param userId
	 */
	public void deleteComExtOrgan(String organId) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {organId};
		executeUpdate(DELETE_BY_ORGAN_ID, types, objs);
	}
	
	/**
	 * 查询外部单位信息
	 * @param ps
	 * @return
	 */
	public DataSet queryExtOrgan(ParameterSet ps) {
		return query(ps);
	}
	
}
