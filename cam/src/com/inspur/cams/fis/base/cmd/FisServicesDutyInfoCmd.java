package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisServicesDutyInfo;
import com.inspur.cams.fis.base.domain.IFisServicesDutyInfoDomain;

/**
 * 殡葬服务机构人员岗位信息表cmd
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesDutyInfoCmd extends BaseAjaxCommand {

	private IFisServicesDutyInfoDomain fisServicesDutyInfoDomain = ScaComponentFactory
			.getService(IFisServicesDutyInfoDomain.class, "fisServicesDutyInfoDomain/fisServicesDutyInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisServicesDutyInfo fisServicesDutyInfo = (FisServicesDutyInfo) record.toBean(FisServicesDutyInfo.class);
		fisServicesDutyInfoDomain.insert(fisServicesDutyInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisServicesDutyInfo fisServicesDutyInfo = (FisServicesDutyInfo) record.toBean(FisServicesDutyInfo.class);
		fisServicesDutyInfoDomain.update(fisServicesDutyInfo);
	}
	
	// 删除
	public void delete() {
		String dutyId = (String) getParameter("dutyId");
		fisServicesDutyInfoDomain.delete(dutyId);
	}
	
}