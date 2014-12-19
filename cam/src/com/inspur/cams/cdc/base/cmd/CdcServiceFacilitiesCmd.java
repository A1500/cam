package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcServiceFacilities;
import com.inspur.cams.cdc.base.domain.ICdcServiceFacilitiesDomain;

/**
 * @title:CdcServiceFacilitiesCommand
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
public class CdcServiceFacilitiesCmd extends BaseAjaxCommand{
	private ICdcServiceFacilitiesDomain cdcServiceFacilitiesDomain = (ICdcServiceFacilitiesDomain) ScaComponentFactory
	.getService(ICdcServiceFacilitiesDomain.class, "cdcServiceFacilitiesDomain/cdcServiceFacilitiesDomain");

	//增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcServiceFacilities dataBean=(CdcServiceFacilities)record.toBean(CdcServiceFacilities.class);
		cdcServiceFacilitiesDomain.insert(dataBean);
	}
	//修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcServiceFacilities dataBean=(CdcServiceFacilities)record.toBean(CdcServiceFacilities.class);
		cdcServiceFacilitiesDomain.update(dataBean);
	}
	//删除
	public void delete() {
		String delIds=(String) getParameter("delIds");
		cdcServiceFacilitiesDomain.delete(delIds);
	}
	
	// 汇总
	public void sum() {
		Record record = (Record) getParameter("record");
		CdcServiceFacilities cdcServiceFacilities = (CdcServiceFacilities) record.toBean(CdcServiceFacilities.class);
		cdcServiceFacilitiesDomain.sum(cdcServiceFacilities);
	}
	/**
	 * 上报社区服务设施
	 */
	public void report(){
		String id = (String) getParameter("id");
		cdcServiceFacilitiesDomain.report(id);
	}
}
