package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmOfficeEquipment;
import com.inspur.cams.jcm.domain.IJcmOfficeEquipmentDomain;

/**
 * 办公设备信息cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmOfficeEquipmentCmd extends BaseAjaxCommand {

	private IJcmOfficeEquipmentDomain jcmOfficeEquipmentDomain = ScaComponentFactory
			.getService(IJcmOfficeEquipmentDomain.class, "jcmOfficeEquipmentDomain/jcmOfficeEquipmentDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmOfficeEquipment jcmOfficeEquipment = (JcmOfficeEquipment) record.toBean(JcmOfficeEquipment.class);
		jcmOfficeEquipmentDomain.insert(jcmOfficeEquipment);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmOfficeEquipment jcmOfficeEquipment = (JcmOfficeEquipment) record.toBean(JcmOfficeEquipment.class);
		jcmOfficeEquipmentDomain.update(jcmOfficeEquipment);
	}
	
	// 删除
	public void delete() {
		String officeId = (String) getParameter("officeId");
		jcmOfficeEquipmentDomain.delete(officeId);
	}
	
}