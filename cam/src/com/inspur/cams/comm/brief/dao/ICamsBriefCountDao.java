package com.inspur.cams.comm.brief.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.brief.data.CamsBriefCount;
import com.inspur.cams.comm.brief.data.CamsBriefSeason;


/**
 * 快报简报数量表dao
 * @author 
 * @date 2014-03-04
 */
public interface ICamsBriefCountDao extends BaseCURD<CamsBriefCount> {
	
	@Trans
	void deleteBySeasonId(String seasonId);
	
	public void insertCount(CamsBriefSeason camsBriefSeason);
	
	public void updateCount(CamsBriefSeason camsBriefSeason);
}