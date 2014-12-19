package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcMailList;

/**
 * 基层民主与社区建设通讯录domain
 * @author shgtch
 * @date 2012-3-1
 */
public interface ICdcMailListDomain {

	/**
	 * 查询基层民主与社区建设通讯录
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加基层民主与社区建设通讯录
	 * @param cdcMailList
	 */
	@Trans
	public void insert(CdcMailList cdcMailList);
	
	/**
	 * 修改基层民主与社区建设通讯录
	 * @param cdcMailList
	 */
	@Trans
	public void update(CdcMailList cdcMailList);
	
	/**
	 * 删除基层民主与社区建设通讯录
	 * @param listId
	 */
	@Trans
	public void delete(String listId);

	public DataSet queryList(ParameterSet pset);

}