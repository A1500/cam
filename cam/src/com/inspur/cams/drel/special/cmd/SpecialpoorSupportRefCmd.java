package com.inspur.cams.drel.special.cmd;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.special.data.SpecialpoorSupportRef;
import com.inspur.cams.drel.special.domain.ISpecialpoorSupportRefDomain;

/**
 * 帮扶关系表cmd
 * 
 * @author
 * @date 2013-08-12
 */
public class SpecialpoorSupportRefCmd extends BaseAjaxCommand {

	private ISpecialpoorSupportRefDomain specialpoorSupportRefDomain = ScaComponentFactory
			.getService(ISpecialpoorSupportRefDomain.class,
					"specialpoorSupportRefDomain/specialpoorSupportRefDomain");

	// 增加
	public void batchInsert() {
		String supportUnitCode = (String) getParameter("supportUnitCode");
		String helpVillageCode = (String) getParameter("helpVillageCode");
		
		List<SpecialpoorSupportRef> specialpoorSupportRefList = new ArrayList<SpecialpoorSupportRef>();
		String[] helpVillageCodes = helpVillageCode.split(";");
		for(int i=0; i<helpVillageCodes.length; i++) {
			if(StringUtils.isNotEmpty(helpVillageCodes[i])) {
				SpecialpoorSupportRef specialpoorSupportRef = new SpecialpoorSupportRef();
				specialpoorSupportRef.setRecordId(IdHelp.getUUID32());
				specialpoorSupportRef.setSupportUnitCode(supportUnitCode);
				specialpoorSupportRef.setHelpVillageCode(helpVillageCodes[i]);
				specialpoorSupportRef.setState(Record.STATE_NEW);
				specialpoorSupportRefList.add(specialpoorSupportRef);
			}
		}
		specialpoorSupportRefDomain.batchInsert(specialpoorSupportRefList);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SpecialpoorSupportRef specialpoorSupportRef = (SpecialpoorSupportRef) record
				.toBean(SpecialpoorSupportRef.class);
		specialpoorSupportRefDomain.update(specialpoorSupportRef);
	}

	// 删除
	public void delete() {
		String recordId = (String) getParameter("recordId");
		specialpoorSupportRefDomain.delete(recordId);
	}

}