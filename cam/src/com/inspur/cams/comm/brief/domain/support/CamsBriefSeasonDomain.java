package com.inspur.cams.comm.brief.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.brief.dao.ICamsBriefCountDao;
import com.inspur.cams.comm.brief.dao.ICamsBriefSeasonDao;
import com.inspur.cams.comm.brief.data.CamsBriefSeason;
import com.inspur.cams.comm.brief.domain.ICamsBriefSeasonDomain;


/**
 * 快报简报配置表domain
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefSeasonDomain implements ICamsBriefSeasonDomain {

	@Reference
	private ICamsBriefSeasonDao camsBriefSeasonDao;
	@Reference
	private ICamsBriefCountDao camsBriefCountDao;
	/**
	 * 查询 快报简报配置表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return camsBriefSeasonDao.query(pset);
	}

	/**
	 * 获取 快报简报配置表
	 * @param pset
	 * @return
	 */
	public CamsBriefSeason get(String SeasonId) {
		return camsBriefSeasonDao.get(SeasonId);
	}

	/**
	 * 增加 快报简报配置表
	 * @param camsBriefSeason
	 */
	public void insert(CamsBriefSeason camsBriefSeason) {
		camsBriefSeasonDao.insert(camsBriefSeason);
		camsBriefCountDao.insertCount(camsBriefSeason);
	}
	
	/**
	 * 修改 快报简报配置表
	 * @param camsBriefSeason
	 */
	public void update(CamsBriefSeason camsBriefSeason) {
		camsBriefSeasonDao.update(camsBriefSeason);
		camsBriefCountDao.updateCount(camsBriefSeason);
	}
	
	/**
	 * 删除 快报简报配置表
	 * @param SeasonId
	 */
	public void delete(String seasonId) {
		camsBriefCountDao.deleteBySeasonId(seasonId);
		camsBriefSeasonDao.delete(seasonId);
		
	}

}