package com.inspur.cams.cdc.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcOrganChange;
import com.inspur.cams.comm.extuser.data.ComExtUser;

/**
 * 社区变更表domain
 * @author 
 * @date 2012-04-13
 */
public interface ICdcOrganChangeDomain {

	/**
	 * 查询 社区变更表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社区
	 * @param comExtUser
	 */
	@Trans
	public void add(ComExtUser comExtUser);
	
	/**
	 * 变更社区
	 * @param comExtUser
	 */
	@Trans
	public void change(ComExtUser comExtUser);
	
	/**
	 * 撤销社区
	 * @param comExtUser
	 */
	@Trans
	public void cancel(String userId);

	/**
	 * 合并社区
	 * @param comExtUser
	 */
	@Trans
	public void merge(ComExtUser comExtUser, List<CdcOrganChange> cdcOrganChangeList);

	/**
	 * 获取 社区变更表
	 * @param pset
	 * @return
	 */
	public CdcOrganChange get(String changeId);

	/**
	 * 增加 社区变更表
	 * @param cdcOrganChange
	 */
	@Trans
	public void insert(CdcOrganChange cdcOrganChange);
	
	/**
	 * 修改 社区变更表
	 * @param cdcOrganChange
	 */
	@Trans
	public void update(CdcOrganChange cdcOrganChange);
	
	/**
	 * 删除 社区变更表
	 * @param changeId
	 */
	@Trans
	public void delete(String changeId);

}