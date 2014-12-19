package com.inspur.cams.comm.extuser.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.extuser.data.ComExtOrgan;

/**
 * 外部单位domain接口
 * @author shgtch
 * @date 2011-6-28
 */
public interface IComExtOrganDomain {

	/**
	 * 获取外部单位信息
	 * @param userId
	 * @return
	 */
	public ComExtOrgan getComExtOrgan(String organId);
	
	/**
	 * 增加外部单位信息
	 * @param comExtUser
	 */
	@Trans
	public ComExtOrgan insertComExtOrgan(ComExtOrgan comExtOrgan);
	
	/**
	 * 更新外部单位信息
	 * @param comExtUser
	 */
	@Trans
	public void updateComExtOrgan(ComExtOrgan comExtOrgan);
	
	/**
	 * 逻辑删除外部单位信息
	 * @param userId
	 */
	@Trans
	public void deleteComExtOrgan(String organId);
	
	/**
	 * 查询外部单位信息
	 * @param ps
	 * @return
	 */
	public DataSet queryExtOrgan(ParameterSet ps);
	
}
