package com.inspur.cams.comm.extuser.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.extuser.data.ComExtOrganType;

/**
 * 外部单位类型domain接口
 * @author shgtch
 * @date 2011-6-28
 */
public interface IComExtOrganTypeDomain {

	/**
	 * 获取外部单位类型
	 * @param userId
	 * @return
	 */
	public ComExtOrganType getComExtOrganType(String code);
	
	/**
	 * 增加外部单位类型
	 * @param comExtUser
	 */
	@Trans
	public void insertComExtOrganType(ComExtOrganType comExtOrganType);
	
	/**
	 * 更新外部单位类型
	 * @param comExtUser
	 */
	@Trans
	public void updateComExtOrganType(ComExtOrganType comExtOrganType);
	
	/**
	 * 删除外部单位类型
	 * @param userId
	 */
	@Trans
	public void deleteComExtOrganType(String code);
	
	/**
	 * 查询外部单位类型
	 * @param ps
	 * @return
	 */
	public DataSet queryExtOrganType(ParameterSet ps);
	
}
