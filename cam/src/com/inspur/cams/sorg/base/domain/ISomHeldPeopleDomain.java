package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomHeldPeople;

/**
 * 社会组织发起人（自然人）domain接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomHeldPeopleDomain {

	/**
	 * 查询发起人（自然人）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加发起人（自然人）
	 * @param somMeeting
	 */
	@Trans
	public void insert(SomHeldPeople somHeldPeople);
	
	/**
	 * 更新发起人（自然人）
	 * @param somMeeting
	 */
	@Trans
	public void update(SomHeldPeople somHeldPeople);

	/**
	 * 删除发起人（自然人）
	 * @param id
	 */
	@Trans
	public void delete(String id);
	
	/**
	 * 通过社会组织内码删除所有发起人（自然人）
	 * @param sorgId
	 */
	@Trans
	public void deleteBySorgId(String sorgId);
	
	/**
	 * 批量增加发起人（自然人）
	 * @param lists
	 */
	@Trans
	public void batchInsert(List<SomHeldPeople> lists);
	
	/**
	 * 批量更新发起人（自然人）
	 * @param lists
	 */
	@Trans
	public void batchUpdate(List<SomHeldPeople> lists);
	
}
