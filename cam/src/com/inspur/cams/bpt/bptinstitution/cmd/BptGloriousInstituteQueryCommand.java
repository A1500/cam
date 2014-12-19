package com.inspur.cams.bpt.bptinstitution.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.bptinstitution.dao.IBptGloriousDetailDao;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousInstitute;
import com.inspur.cams.bpt.bptinstitution.data.BptHospital;
import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;

/**
 * @title:BptGloriousInstituteQueryCommand
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
 */
public class BptGloriousInstituteQueryCommand extends BaseQueryCommand {

	private  Record record = null;

	DicCityDao citydao = (DicCityDao) DaoFactory
			.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");

	IBptGloriousDetailDao BbptGloriousdetaildao = (IBptGloriousDetailDao) DaoFactory
			.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptGloriousDetailDao");

	public DataSet execute() {
		DataSet ds = null;
		ParameterSet pset = getParameterSet();
		ParameterSet psetDetail = new ParameterSet();
		EntityDao<BptGloriousInstitute> dao = (EntityDao<BptGloriousInstitute>) DaoFactory
				.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptGloriousInstituteDao");
		if (pset.containsKey("years")) {
			String years = (String) pset.get("years");
			String hospitalId = (String) pset.get("GLORIOUS_ID");
			String id = hospitalId + years;
			psetDetail.setParameter("ID", id);
			ds = BbptGloriousdetaildao.query(psetDetail);
			pset.remove("GLORIOUS_ID");
			pset.remove("years");
			if (ds.getCount() < 1) {
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
			if (pset.containsKey("GLORIOUS_ID@=")) {
				pset.setSortField("years");
				pset.setSortDir("desc");
				DataSet ds1 = BbptGloriousdetaildao.query(pset);
				ds = new DataSet(ds1.getRecord(0));
			} else {
				ds = dao.query(pset);
			}

		}
		ParameterSet pt = new ParameterSet();
		for (int j = 0; j < ds.getCount(); j++) {
			String domicileCode = (String) ds.getRecord(j).get("domicileCode");
			pt.setParameter("ID", domicileCode);
			DataSet cityds = citydao.query(pt);
			if (cityds.getCount() > 0) {
				String name = (String) cityds.getRecord(0).get("fullName");
				ds.getRecord(j).set("domicileName", name);
			}
		}
		return ds;
	}
	public DataSet getGloriousDetail(){
		ParameterSet ps = getParameterSet();
		ps.setSortField("years");
		ps.setSortDir("desc");
		return BbptGloriousdetaildao.query(ps);
		
		
	}
	/**
	 * 查询光荣院
	 * @return
	 */
	public DataSet queryGlorious(){
		ParameterSet ps = getParameterSet();
		ps.setSortField("years");
		ps.setSortDir("desc");
		return BbptGloriousdetaildao.queryGlorious(ps);		
	}
}