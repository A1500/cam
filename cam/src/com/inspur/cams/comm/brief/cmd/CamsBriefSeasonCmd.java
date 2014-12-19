package com.inspur.cams.comm.brief.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.brief.data.CamsBriefSeason;
import com.inspur.cams.comm.brief.domain.ICamsBriefSeasonDomain;


/**
 * 快报简报配置表cmd
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefSeasonCmd extends BaseAjaxCommand {

	private ICamsBriefSeasonDomain camsBriefSeasonDomain = ScaComponentFactory
			.getService(ICamsBriefSeasonDomain.class, "camsBriefSeasonDomain/camsBriefSeasonDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CamsBriefSeason camsBriefSeason = (CamsBriefSeason) record.toBean(CamsBriefSeason.class);
		camsBriefSeasonDomain.insert(camsBriefSeason);
		
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CamsBriefSeason camsBriefConfig = (CamsBriefSeason) record.toBean(CamsBriefSeason.class);
		camsBriefSeasonDomain.update(camsBriefConfig);
	}
	
	// 删除
	public void delete() {
		String seasonId = (String) getParameter("seasonId");
		camsBriefSeasonDomain.delete(seasonId);
	}
	
}