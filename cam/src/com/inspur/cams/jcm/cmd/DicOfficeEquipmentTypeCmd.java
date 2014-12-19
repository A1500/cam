package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.DicOfficeEquipmentType;
import com.inspur.cams.jcm.domain.IDicOfficeEquipmentTypeDomain;

/**
 * 办公设备类别cmd
 * @author 
 * @date 2014-05-21
 */
public class DicOfficeEquipmentTypeCmd extends BaseAjaxCommand {

	private IDicOfficeEquipmentTypeDomain dicOfficeEquipmentTypeDomain = ScaComponentFactory
			.getService(IDicOfficeEquipmentTypeDomain.class, "dicOfficeEquipmentTypeDomain/dicOfficeEquipmentTypeDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicOfficeEquipmentType dicOfficeEquipmentType = (DicOfficeEquipmentType) record.toBean(DicOfficeEquipmentType.class);
		dicOfficeEquipmentTypeDomain.insert(dicOfficeEquipmentType);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicOfficeEquipmentType dicOfficeEquipmentType = (DicOfficeEquipmentType) record.toBean(DicOfficeEquipmentType.class);
		dicOfficeEquipmentTypeDomain.update(dicOfficeEquipmentType);
	}
	
	// 删除
	public void delete() {
		String code = (String) getParameter("code");
		dicOfficeEquipmentTypeDomain.delete(code);
	}
	
}