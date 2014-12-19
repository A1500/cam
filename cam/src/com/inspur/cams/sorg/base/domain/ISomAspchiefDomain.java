package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomAspchief;

/**
 * 社会组织拟任负责人domain接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomAspchiefDomain {

	/**
	 * 查询拟任负责人
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加拟任负责人
	 * @param somMeeting
	 */
	@Trans
	public void insert(SomAspchief somAspchief);
	
	/**
	 * 更新拟任负责人
	 * @param somMeeting
	 */
	@Trans
	public void update(SomAspchief somAspchief);

	/**
	 * 删除拟任负责人
	 * @param id
	 */
	@Trans
	public void delete(String id);
	
	/**
	 * 通过社会组织内码删除拟任负责人
	 * @param sorgId
	 */
	@Trans
	public void deleteBySorgId(String sorgId);
	
	/**
	 * 批量增加拟任负责人
	 * @param lists
	 */
	@Trans
	public void batchInsert(List<SomAspchief> lists);
	
	/**
	 * 批量更新拟任负责人
	 * @param lists
	 */
	@Trans
	public void batchUpdate(List<SomAspchief> lists);
	/**
	 * 根据taskCode删除
	 * @param taskCode
	 */
	@Trans
	public void deleteAllAspchiefByTaskCode(String taskCode);
	
}
