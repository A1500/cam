package com.inspur.cams.comm.brief.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.brief.data.CamsBriefCount;


/**
 * 快报简报数量表domain
 * @author 
 * @date 2014-03-04
 */
public interface ICamsBriefCountDomain {

	/**
	 * 查询 快报简报数量表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 快报简报数量表
	 * @param pset
	 * @return
	 */
	public CamsBriefCount get(String countId);

	/**
	 * 增加 快报简报数量表
	 * @param camsBriefCount
	 */
	@Trans
	public void insert(CamsBriefCount camsBriefCount);
	
	/**
	 * 修改 快报简报数量表
	 * @param camsBriefCount
	 */
	@Trans
	public void update(CamsBriefCount camsBriefCount);
	
	/**
	 * 删除 快报简报数量表
	 * @param countId
	 */
	@Trans
	public void delete(String countId);

	@Trans
	public void saveBrief(CamsBriefCount camsBriefCount);
}