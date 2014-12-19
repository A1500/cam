package com.inspur.cams.comm.extuser.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.extuser.data.ComExtOrganType;

/**
 * 外部单位类型dao接口
 * @author shgtch
 * @date 2011-6-29
 */
public interface IComExtOrganTypeDao {

	/**
	 * 获取外部单位类型
	 * @param userId
	 * @return
	 */
	public ComExtOrganType getComExtOrganType(String organId);
	
	/**
	 * 增加外部单位类型
	 * @param comExtUser
	 */
	public void insertComExtOrganType(ComExtOrganType comExtOrganType);
	
	/**
	 * 更新外部单位类型
	 * @param comExtUser
	 */
	public void updateComExtOrganType(ComExtOrganType comExtOrganType);
	
	/**
	 * 删除外部单位类型
	 * @param userId
	 */
	public void deleteComExtOrganType(String code);

	/**
	 * 查询外部单位类型
	 * @param ps
	 * @return
	 */
	public DataSet queryExtOrganType(ParameterSet ps);
	
}
