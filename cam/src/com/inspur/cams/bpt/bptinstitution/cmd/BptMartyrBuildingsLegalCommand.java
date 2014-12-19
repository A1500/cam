package com.inspur.cams.bpt.bptinstitution.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildingsLegal;
import com.inspur.cams.bpt.bptinstitution.domain.IBptMartyrBuildingsDomain;



/**
 * @title:BptMartyrBuildingsLegalCommand
 * @description:
 * @author:
 * @since:2011-06-15
 * @version:1.0
*/
public class BptMartyrBuildingsLegalCommand extends BaseQueryCommand {

	public DataSet execute() {
		IBptMartyrBuildingsDomain bptmartyrbuildingsDomain = ScaComponentFactory.getService(IBptMartyrBuildingsDomain.class,
		"BptMartyrBuildingsDomain/BptMartyrBuildingsDomain");
		ParameterSet pset = getParameterSet();
		return bptmartyrbuildingsDomain.queryBptMartyrBuildingsLegal(pset);
	}
	@Trans
	public void save() {
		IBptMartyrBuildingsDomain bptmartyrbuildingsDomain = ScaComponentFactory.getService(IBptMartyrBuildingsDomain.class,
				"BptMartyrBuildingsDomain/BptMartyrBuildingsDomain");
		Record[] bptmartyrbuildingslegalRecords = (Record[]) getParameter("bptmartyrbuildingslegalRecords");
		List<BptMartyrBuildingsLegal> list = new ArrayList<BptMartyrBuildingsLegal>();
		for (int i = 0; i < bptmartyrbuildingslegalRecords.length; i++) {
			BptMartyrBuildingsLegal bptmartyrbuildingslegal = (BptMartyrBuildingsLegal)bptmartyrbuildingslegalRecords[i].toBean(BptMartyrBuildingsLegal.class);
			list.add(bptmartyrbuildingslegal);
		}
		bptmartyrbuildingsDomain.saveBptMartyrBuildingsLegal(list);
	}
	@Trans
	public void delete() {
		EntityDao<BptMartyrBuildingsLegal> dao = (EntityDao<BptMartyrBuildingsLegal>) DaoFactory
		.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptMartyrBuildingsLegalDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}