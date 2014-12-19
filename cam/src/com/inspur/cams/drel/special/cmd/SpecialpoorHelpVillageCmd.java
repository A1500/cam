package com.inspur.cams.drel.special.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.special.data.SpecialpoorHelpVillage;
import com.inspur.cams.drel.special.domain.ISpecialpoorHelpVillageDomain;

/**
 * 帮包村信息表cmd
 * @author 
 * @date 2013-08-12
 */
public class SpecialpoorHelpVillageCmd extends BaseAjaxCommand {

	private ISpecialpoorHelpVillageDomain specialpoorHelpVillageDomain = ScaComponentFactory
			.getService(ISpecialpoorHelpVillageDomain.class, "specialpoorHelpVillageDomain/specialpoorHelpVillageDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SpecialpoorHelpVillage specialpoorHelpVillage = (SpecialpoorHelpVillage) record.toBean(SpecialpoorHelpVillage.class);
		specialpoorHelpVillageDomain.insert(specialpoorHelpVillage);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SpecialpoorHelpVillage specialpoorHelpVillage = (SpecialpoorHelpVillage) record.toBean(SpecialpoorHelpVillage.class);
		specialpoorHelpVillageDomain.update(specialpoorHelpVillage);
	}
	
	// 删除
	public void delete() {
		String helpVillageCode = (String) getParameter("helpVillageCode");
		specialpoorHelpVillageDomain.delete(helpVillageCode);
	}
	
}