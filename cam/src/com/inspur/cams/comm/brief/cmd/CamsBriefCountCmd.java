package com.inspur.cams.comm.brief.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.brief.data.CamsBriefCount;
import com.inspur.cams.comm.brief.domain.ICamsBriefCountDomain;


/**
 * 快报简报数量表cmd
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefCountCmd extends BaseAjaxCommand {

	private ICamsBriefCountDomain camsBriefCountDomain = ScaComponentFactory
			.getService(ICamsBriefCountDomain.class, "camsBriefCountDomain/camsBriefCountDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CamsBriefCount camsBriefCount = (CamsBriefCount) record.toBean(CamsBriefCount.class);
		camsBriefCountDomain.insert(camsBriefCount);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CamsBriefCount camsBriefCount = (CamsBriefCount) record.toBean(CamsBriefCount.class);
		camsBriefCountDomain.update(camsBriefCount);
	}
	
	// 删除
	public void delete() {
		String countId = (String) getParameter("countId");
		camsBriefCountDomain.delete(countId);
	}
	
	// 保存
	public void saveBrief() {
		Record[] records = (Record[]) getParameter("records");
		if (records != null) {
			for (int i = 0; i < records.length; i++) {
				CamsBriefCount camsBriefCount = (CamsBriefCount) records[i].toBean(CamsBriefCount.class);
				camsBriefCountDomain.saveBrief(camsBriefCount);
			}
		}
	}
}