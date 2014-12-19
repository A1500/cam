package com.inspur.cams.bpt.bptinstitution.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.bptinstitution.data.BptHospitalLegal;
import com.inspur.cams.bpt.bptinstitution.domain.IBptHospitalDomain;

/**
 * @title:BptHospitalLegalCommand
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
public class BptHospitalLegalCommand extends BaseQueryCommand {

	public DataSet execute() {
		IBptHospitalDomain bpthospitalDomain = ScaComponentFactory.getService(IBptHospitalDomain.class,
		"BptHospitalDomain/BptHospitalDomain");
		ParameterSet pset = getParameterSet();
		return bpthospitalDomain.queryBptHospitalLegal(pset);
	}
	@Trans
	public void save() {
		IBptHospitalDomain bpthospitalDomain = ScaComponentFactory.getService(IBptHospitalDomain.class,
				"BptHospitalDomain/BptHospitalDomain");
		Record[] bpthospitallegalRecords = (Record[]) getParameter("bpthospitallegalRecords");
		List<BptHospitalLegal> list = new ArrayList<BptHospitalLegal>();
		for (int i = 0; i < bpthospitallegalRecords.length; i++) {
			BptHospitalLegal bpthospitallegal = (BptHospitalLegal)bpthospitallegalRecords[i].toBean(BptHospitalLegal.class);
			list.add(bpthospitallegal);
		}
		bpthospitalDomain.saveBptHospitalLegal(list);
	}
	@Trans
	public void delete() {
		EntityDao<BptHospitalLegal> dao = (EntityDao<BptHospitalLegal>) DaoFactory
		.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptHospitalLegalDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}