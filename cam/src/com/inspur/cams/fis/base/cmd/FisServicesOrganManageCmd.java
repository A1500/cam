package com.inspur.cams.fis.base.cmd;

import org.loushang.bsp.util.uuid.UUIDGenerator;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.base.data.FisServicesOrganManage;
import com.inspur.cams.fis.base.domain.IFisServicesOrganManageDomain;

/**
 * 殡葬服务机构信息表cmd
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesOrganManageCmd extends BaseAjaxCommand {

	private IFisServicesOrganManageDomain fisServicesOrganManageDomain = ScaComponentFactory
			.getService(IFisServicesOrganManageDomain.class, "fisServicesOrganManageDomain/fisServicesOrganManageDomain");
	
	// 增加
	public void insert() {
        UUIDGenerator uuidgenerator = new UUIDGenerator();
		Record record = (Record) getParameter("record");
		FisServicesOrganManage fisServicesOrganManage = (FisServicesOrganManage) record.toBean(FisServicesOrganManage.class);
		fisServicesOrganManage.setRecordId((String)uuidgenerator.getNextSeqId(30));
		fisServicesOrganManageDomain.insert(fisServicesOrganManage);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisServicesOrganManage fisServicesOrganManage = (FisServicesOrganManage) record.toBean(FisServicesOrganManage.class);
		fisServicesOrganManageDomain.update(fisServicesOrganManage);
	}
	
	// 删除
	public void delete() {
		String recordId = (String) getParameter("recordId");
		fisServicesOrganManageDomain.delete(recordId);
	}
}