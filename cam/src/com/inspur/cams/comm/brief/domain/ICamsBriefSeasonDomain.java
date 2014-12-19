package com.inspur.cams.comm.brief.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.brief.data.CamsBriefSeason;


/**
 * 快报简报配置表domain
 * @author 
 * @date 2014-03-04
 */
public interface ICamsBriefSeasonDomain {

	/**
	 * 查询 快报简报配置表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 获取 快报简报配置表
	 * @param pset
	 * @return
	 */
	public CamsBriefSeason get(String SeasonId);

	/**
	 * 增加 快报简报配置表
	 * @param camsBriefSeason
	 */
	@Trans
	public void insert(CamsBriefSeason camsBriefSeason);
	
	/**
	 * 修改 快报简报配置表
	 * @param camsBriefSeason
	 */
	@Trans
	public void update(CamsBriefSeason camsBriefSeason);
	
	/**
	 * 删除 快报简报配置表
	 * @param SeasonId
	 */
	@Trans
	public void delete(String seasonId);

}