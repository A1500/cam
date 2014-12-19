package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomHeldOrgan;

/**
 * 社会组织发起人（单位）domain接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomHeldOrganDomain {

	/**
	 * 查询发起人（单位）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加发起人（单位）
	 * @param somMeeting
	 */
	@Trans
	public void insert(SomHeldOrgan somHeldOrgan);
	
	/**
	 * 更新发起人（单位）
	 * @param somHeldOrgan
	 */
	@Trans
	public void update(SomHeldOrgan somHeldOrgan);

	/**
	 * 删除发起人（单位）
	 * @param id
	 */
	@Trans
	public void delete(String id);
	
	/**
	 * 通过社会组织内码删除所有发起人（单位）
	 * @param sorgId
	 */
	@Trans
	public void deleteBySorgId(String sorgId);
	
	/**
	 * 批量增加发起人（单位）
	 * @param lists
	 */
	@Trans
	public void batchInsert(List<SomHeldOrgan> lists);
	
	/**
	 * 批量更新发起人（单位）
	 * @param lists
	 */
	@Trans
	public void batchUpdate(List<SomHeldOrgan> lists);
	
}
