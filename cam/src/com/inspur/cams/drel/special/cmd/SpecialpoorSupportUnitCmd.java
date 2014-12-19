package com.inspur.cams.drel.special.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.special.data.SpecialpoorSupportUnit;
import com.inspur.cams.drel.special.domain.ISpecialpoorSupportUnitDomain;

/**
 * 特殊困难帮扶单位信息表cmd
 * @author 
 * @date 2013-08-12
 */
public class SpecialpoorSupportUnitCmd extends BaseAjaxCommand {

	private ISpecialpoorSupportUnitDomain specialpoorSupportUnitDomain = ScaComponentFactory
			.getService(ISpecialpoorSupportUnitDomain.class, "specialpoorSupportUnitDomain/specialpoorSupportUnitDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SpecialpoorSupportUnit specialpoorSupportUnit = (SpecialpoorSupportUnit) record.toBean(SpecialpoorSupportUnit.class);
		specialpoorSupportUnitDomain.insert(specialpoorSupportUnit);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SpecialpoorSupportUnit specialpoorSupportUnit = (SpecialpoorSupportUnit) record.toBean(SpecialpoorSupportUnit.class);
		specialpoorSupportUnitDomain.update(specialpoorSupportUnit);
	}
	
	// 删除
	public void delete() {
		String supportUnitCode = (String) getParameter("supportUnitCode");
		specialpoorSupportUnitDomain.delete(supportUnitCode);
	}
	
}