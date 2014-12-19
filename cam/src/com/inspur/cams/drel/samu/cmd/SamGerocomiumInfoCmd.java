package com.inspur.cams.drel.samu.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.samu.data.SamBedInfo;
import com.inspur.cams.drel.samu.data.SamGerocomiumInfo;
import com.inspur.cams.drel.samu.data.SamRoomInfo;
import com.inspur.cams.drel.samu.data.SamWorkerInfo;
import com.inspur.cams.drel.samu.domain.ISamGerocomiumInfoDomain;
import com.inspur.cams.drel.samu.domain.ISamWorkerInfoDomain;


/**
 * 敬老院基础信息cmd
 * @author 
 * @date 2012-09-26
 */
public class SamGerocomiumInfoCmd extends BaseAjaxCommand {

	private ISamGerocomiumInfoDomain samGerocomiumInfoDomain = ScaComponentFactory
			.getService(ISamGerocomiumInfoDomain.class, "samGerocomiumInfoDomain/samGerocomiumInfoDomain");
	private ISamWorkerInfoDomain samWorkerInfoDomain = ScaComponentFactory
			.getService(ISamWorkerInfoDomain.class, "samWorkerInfoDomain/samWorkerInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamGerocomiumInfo samGerocomiumInfo = (SamGerocomiumInfo) record.toBean(SamGerocomiumInfo.class);
		samGerocomiumInfoDomain.insert(samGerocomiumInfo);
	}

	// 修改
	public void update() {
		Record recordGerocomium = (Record) getParameter("recordGerocomium");
		Record[] recordRoom = (Record[]) getParameter("recordRoom");
		Record[] recordBed = (Record[]) getParameter("recordBed");
		Record[] recordWorker = (Record[]) getParameter("recordWorker");
		samGerocomiumInfoDomain.updateGerocomium(recordGerocomium,recordRoom,recordBed,recordWorker);	
	}
	
	// 删除
	public void delete() {
		String gerocomiumId = (String) getParameter("gerocomiumId");
		samGerocomiumInfoDomain.delete(gerocomiumId);
	}
	//保存敬老院、房间、人员基本信息
	public void save(){
		Record recordGerocomium = (Record) getParameter("recordGerocomium");
		Record[] recordRoom = (Record[]) getParameter("recordRoom");
		Record[] recordBed = (Record[]) getParameter("recordBed");
		String recordId = (String) getParameter("recordId");
		Record[] recordWorker = (Record[]) getParameter("recordWorker");
		SamGerocomiumInfo samGerocomiumInfo = (SamGerocomiumInfo) recordGerocomium.toBean(SamGerocomiumInfo.class);
	
		SamGerocomiumInfo samGerocomiumInfoTurn =samGerocomiumInfoDomain.savesamGerocomiumInfo(recordId,samGerocomiumInfo,recordWorker);
		this.setReturn("returnRecordId", samGerocomiumInfoTurn.getRecordId());
		this.setReturn("returnGerocomiumId", samGerocomiumInfoTurn.getGerocomiumId());
		
		
	}
	//删除敬老院、房间及员工信息
	public void deleteAll() {
		String gerocomiumId = (String) getParameter("gerocomiumId");
		samGerocomiumInfoDomain.deleteAll(gerocomiumId);
	}
}