package com.inspur.cams.bpt.bptinstitution.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.bptinstitution.data.BptHospital;
import com.inspur.cams.bpt.bptinstitution.domain.IBptHospitalDomain;
import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.bpt.bptinstitution.dao.IBptHospitalDetailDao;

/**
 * @title:BptHospitalQueryCommand
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
 */
public class BptHospitalQueryCommand extends BaseQueryCommand {

	IBptHospitalDomain service = ScaComponentFactory.getService(
			IBptHospitalDomain.class, "BptHospitalDomain/BptHospitalDomain");
	DicCityDao citydao = (DicCityDao) DaoFactory
			.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
	IBptHospitalDetailDao bpthospitaldetaildao = (IBptHospitalDetailDao) DaoFactory
			.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptHospitalDetailDao");

	EntityDao<BptHospital> dao = (EntityDao<BptHospital>) DaoFactory
			.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptHospitalDao");

	public DataSet execute() {
		DataSet ds = null;
		ParameterSet pset = getParameterSet();
		ParameterSet psetDetail = new ParameterSet();
		if (pset.containsKey("years")) {
			String years = (String) pset.get("years");
			String hospitalId = (String) pset.get("HOSPITAL_ID");
			String id = hospitalId + years;
			psetDetail.setParameter("ID", id);
			ds = bpthospitaldetaildao.query(psetDetail);
			pset.remove("HOSPITAL_ID");
			pset.remove("years");
			int dsCount = ds.getCount();
			if (dsCount < 1) {
				ds = dao.query(pset);
			}
			ParameterSet pt = new ParameterSet();
			for (int j = 0; j < ds.getCount(); j++) {
				String domicileCode = (String) ds.getRecord(j).get(
						"domicileCode");
				pt.setParameter("ID", domicileCode);
				DataSet cityds = citydao.query(pt);
				if (cityds.getCount() > 0) {
					String name = (String) cityds.getRecord(0).get("fullName");
					ds.getRecord(j).set("domicileName", name);
					ds.getRecord(j).set("years", years);

				}
			}
		} else {
			if (pset.containsKey("HOSPITAL_ID@=")) {
				pset.setSortField("years");
				pset.setSortDir("desc");
				DataSet ds1 = bpthospitaldetaildao.query(pset);
				int s = ds1.getCount();
				ds = new DataSet(ds1.getRecord(0));
				
			} else {
				ds = dao.query(pset);
			}
			int count = ds.getCount();
			ParameterSet pt = new ParameterSet();
			for (int j = 0; j < count; j++) {
				String domicileCode = (String) ds.getRecord(j).get(
						"domicileCode");
				pt.setParameter("ID", domicileCode);
				DataSet cityds = citydao.query(pt);
				if (cityds.getCount() > 0) {
					String name = (String) cityds.getRecord(0).get("fullName");
					ds.getRecord(j).set("domicileName", name);
				}
			}
		}
		return ds;

	}

	public DataSet getDetail() {
		DataSet ds;
		ParameterSet ps = getParameterSet();
		ps.setSortField("years");
		ps.setSortDir("desc");
		// ps.get("HOSPITAL_ID");
		return bpthospitaldetaildao.query(ps);
	}
	public DataSet getHospitalTotal(){//优抚医院查询统计
		ParameterSet ps = getParameterSet();
		DataSet ds = bpthospitaldetaildao.getHospitalTotal(ps);
		return ds;
	}
}