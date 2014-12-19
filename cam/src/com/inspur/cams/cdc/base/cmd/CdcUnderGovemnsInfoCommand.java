package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcUnderGovemnsInfo;
import com.inspur.cams.cdc.base.domain.ICdcUnderGovemnsInfoDomain;

/**
 * @title:CdcUnderGovemnsInfoCommand
 * @description:
 * @author:
 * @since:2013-03-15
 * @version:1.0
*/
public class CdcUnderGovemnsInfoCommand extends BaseAjaxCommand{
	private ICdcUnderGovemnsInfoDomain cdcUnderGovemnsInfoDomain = ScaComponentFactory
	.getService(ICdcUnderGovemnsInfoDomain.class, "cdcUnderGovemnsInfoDomain/cdcUnderGovemnsInfoDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		CdcUnderGovemnsInfo dataBean=(CdcUnderGovemnsInfo)record.toBean(CdcUnderGovemnsInfo.class);
		cdcUnderGovemnsInfoDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		CdcUnderGovemnsInfo dataBean=(CdcUnderGovemnsInfo)record.toBean(CdcUnderGovemnsInfo.class);
		cdcUnderGovemnsInfoDomain.update(dataBean);
	}

	public void delete() {
		String[] ids =(String[]) getParameter("delIds");
		cdcUnderGovemnsInfoDomain.batchDelete(ids);
	}
	
	//保存下辖村信息
	public void save() {
		Record record = (Record) getParameter("record");
		CdcUnderGovemnsInfo dataBean=(CdcUnderGovemnsInfo)record.toBean(CdcUnderGovemnsInfo.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("VILLAGE_CODE@=", dataBean.getVillageCode());
		DataSet ds = cdcUnderGovemnsInfoDomain.query(pset);
		if(ds.getCount()<1){
			cdcUnderGovemnsInfoDomain.insert(dataBean);
		}else{
			cdcUnderGovemnsInfoDomain.update(dataBean);
		}
		
		
	}
}
