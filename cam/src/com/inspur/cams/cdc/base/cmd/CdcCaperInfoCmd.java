package com.inspur.cams.cdc.base.cmd;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcCaperInfo;
import com.inspur.cams.cdc.base.data.CdcVoluntaryCaperInfo;
import com.inspur.cams.cdc.base.data.CdcVoluntaryInfo;
import com.inspur.cams.cdc.base.domain.ICdcCaperInfoDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 活动信息cmd
 * @author 
 * @date 2013-02-26
 */
public class CdcCaperInfoCmd extends BaseAjaxCommand {

	private ICdcCaperInfoDomain cdcCaperInfoDomain = ScaComponentFactory
			.getService(ICdcCaperInfoDomain.class, "cdcCaperInfoDomain/cdcCaperInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("cdcCaperInfo");
		CdcCaperInfo cdcCaperInfo = (CdcCaperInfo) record.toBean(CdcCaperInfo.class);

		Record[] records = (Record[]) getParameter("cdcVoluntaryInfos");
		if(records.length>0) {
			cdcCaperInfo.setCaperId(IdHelp.getUUID32());
			cdcCaperInfo.setCreateTime(DateUtil.getTime());
			List<CdcVoluntaryInfo> cdcVoluntaryInfoList = new ArrayList<CdcVoluntaryInfo>();
			List<CdcVoluntaryCaperInfo> cdcVoluntaryCaperInfoList = new ArrayList<CdcVoluntaryCaperInfo>();
			for(int i=0;i<records.length;i++) {
				CdcVoluntaryInfo cdcVoluntaryInfo = (CdcVoluntaryInfo) records[i].toBean(CdcVoluntaryInfo.class);
				cdcVoluntaryInfoList.add(cdcVoluntaryInfo);
				
				CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo = new CdcVoluntaryCaperInfo();
				cdcVoluntaryCaperInfo.setRecordId(IdHelp.getUUID32());
				cdcVoluntaryCaperInfo.setCaperId(cdcCaperInfo.getCaperId());
				cdcVoluntaryCaperInfo.setVoluntaryId(cdcVoluntaryInfo.getVoluntaryId());
				cdcVoluntaryCaperInfo.setStartTime(cdcVoluntaryInfo.getStartTime());
				cdcVoluntaryCaperInfo.setEndTime(cdcVoluntaryInfo.getEndTime());
				cdcVoluntaryCaperInfo.setDiffTimes(cdcVoluntaryInfo.getTotalTimes());
				cdcVoluntaryCaperInfoList.add(cdcVoluntaryCaperInfo);
			}
			cdcCaperInfo.setCdcVoluntaryInfoList(cdcVoluntaryInfoList);
			cdcCaperInfo.setCdcVoluntaryCaperInfoList(cdcVoluntaryCaperInfoList);
			cdcCaperInfo.setCaperNums(new BigDecimal(cdcVoluntaryInfoList.size()));
			cdcCaperInfoDomain.insert(cdcCaperInfo);
			setReturn("flag", "T");
		}else {
			setReturn("flag", "F");
		}
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("cdcCaperInfo");
		CdcCaperInfo cdcCaperInfo = (CdcCaperInfo) record.toBean(CdcCaperInfo.class);

		Record[] records = (Record[]) getParameter("cdcVoluntaryInfos");
		if(records.length>0) {
			List<CdcVoluntaryInfo> cdcVoluntaryInfoList = new ArrayList<CdcVoluntaryInfo>();
			List<CdcVoluntaryCaperInfo> cdcVoluntaryCaperInfoList = new ArrayList<CdcVoluntaryCaperInfo>();
			for(int i=0;i<records.length;i++) {
				CdcVoluntaryInfo cdcVoluntaryInfo = (CdcVoluntaryInfo) records[i].toBean(CdcVoluntaryInfo.class);
				cdcVoluntaryInfoList.add(cdcVoluntaryInfo);
				
				CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo = new CdcVoluntaryCaperInfo();
				cdcVoluntaryCaperInfo.setRecordId(IdHelp.getUUID32());
				cdcVoluntaryCaperInfo.setCaperId(cdcCaperInfo.getCaperId());
				cdcVoluntaryCaperInfo.setVoluntaryId(cdcVoluntaryInfo.getVoluntaryId());
				cdcVoluntaryCaperInfo.setStartTime(cdcVoluntaryInfo.getStartTime());
				cdcVoluntaryCaperInfo.setEndTime(cdcVoluntaryInfo.getEndTime());
				cdcVoluntaryCaperInfo.setDiffTimes(cdcVoluntaryInfo.getTotalTimes());
				cdcVoluntaryCaperInfoList.add(cdcVoluntaryCaperInfo);
			}
			cdcCaperInfo.setCdcVoluntaryInfoList(cdcVoluntaryInfoList);
			cdcCaperInfo.setCdcVoluntaryCaperInfoList(cdcVoluntaryCaperInfoList);
			cdcCaperInfo.setCaperNums(new BigDecimal(cdcVoluntaryInfoList.size()));
			cdcCaperInfoDomain.update(cdcCaperInfo);
			setReturn("flag", "T");
		}else {
			setReturn("flag", "F");
		}
	}
	
	// 删除活动
	public void deleteCaper() {
		String caperId = (String) getParameter("caperId");
		cdcCaperInfoDomain.deleteCaper(caperId);
	}
}