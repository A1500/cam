package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.samu.data.SamBedInfo;
import com.inspur.cams.drel.samu.domain.ISamBedInfoDomain;
/**
 * 床位信息cmd
 * @author 
 * @date 2012-09-26
 */
public class SamBedInfoCmd extends BaseAjaxCommand {

	private ISamBedInfoDomain samBedInfoDomain = ScaComponentFactory
			.getService(ISamBedInfoDomain.class, "samBedInfoDomain/samBedInfoDomain");
	
	// 增加
	public void insert() {
		String bedId=IdHelp.getUUID32();
		Record record = (Record) getParameter("record");
		record.set("bedId", bedId);
		SamBedInfo samBedInfo = (SamBedInfo) record.toBean(SamBedInfo.class);
		samBedInfoDomain.insert(samBedInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamBedInfo samBedInfo = (SamBedInfo) record.toBean(SamBedInfo.class);
		samBedInfoDomain.update(samBedInfo);
	}
	
	// 删除
	public void delete() {
		String bedId = (String) getParameter("bedId");
		samBedInfoDomain.delete(bedId);
	}
	
}