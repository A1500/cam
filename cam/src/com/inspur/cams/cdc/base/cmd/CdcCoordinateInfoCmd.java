package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcCoordinateInfo;
import com.inspur.cams.cdc.base.domain.ICdcCoordinateInfoDomain;

/**
 * 社区建设领导协调机制信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcCoordinateInfoCmd extends BaseAjaxCommand {

	private ICdcCoordinateInfoDomain cdcCoordinateInfoDomain = ScaComponentFactory
			.getService(ICdcCoordinateInfoDomain.class, "cdcCoordinateInfoDomain/cdcCoordinateInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcCoordinateInfo cdcCoordinateInfo = (CdcCoordinateInfo) record.toBean(CdcCoordinateInfo.class);
		cdcCoordinateInfoDomain.insert(cdcCoordinateInfo);
	}

	// 查询
	public void update() {
		Record record = (Record) getParameter("record");
		CdcCoordinateInfo cdcCoordinateInfo = (CdcCoordinateInfo) record.toBean(CdcCoordinateInfo.class);
		cdcCoordinateInfoDomain.update(cdcCoordinateInfo);
	}
	
	public void report(){
		String id = (String) getParameter("id");
		cdcCoordinateInfoDomain.report(id);
	}
	
	// 驳回
	public void audit() {
		String id = (String) getParameter("id");
		cdcCoordinateInfoDomain.audit(id);
	}

}