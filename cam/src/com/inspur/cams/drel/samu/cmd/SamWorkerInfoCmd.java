package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.samu.data.SamWorkerInfo;
import com.inspur.cams.drel.samu.domain.ISamWorkerInfoDomain;

/**
 * 工作人员信息cmd
 * @author 
 * @date 2012-09-26
 */
public class SamWorkerInfoCmd extends BaseAjaxCommand {

	private ISamWorkerInfoDomain samWorkerInfoDomain = ScaComponentFactory
			.getService(ISamWorkerInfoDomain.class, "samWorkerInfoDomain/samWorkerInfoDomain");
	
	// 增加
	public void insert() {
		String workerId=IdHelp.getUUID32();
		Record record = (Record) getParameter("record");
		record.set("workerId", workerId);
		SamWorkerInfo samWorkerInfo = (SamWorkerInfo) record.toBean(SamWorkerInfo.class);
		samWorkerInfoDomain.insert(samWorkerInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamWorkerInfo samWorkerInfo = (SamWorkerInfo) record.toBean(SamWorkerInfo.class);
		samWorkerInfoDomain.update(samWorkerInfo);
	}
	
	// 删除
	public void delete() {
		String workerId = (String) getParameter("workerId");
		samWorkerInfoDomain.delete(workerId);
	}
	
}