package com.inspur.cams.bpt.bptinstitution.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.bptinstitution.dao.IBptMartyrBuildingsDao;
import com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptMartyrBuildingsDao;
import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;


/**
 * @title:BptMartyrBuildingsQueryCommand
 * @description:
 * @author:
 * @since:2011-06-15
 * @version:1.0
*/
public class BptMartyrBuildingsQueryCommand extends BaseQueryCommand {
	private IBptMartyrBuildingsDao dao = (BptMartyrBuildingsDao) DaoFactory.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptMartyrBuildingsDao");
	private DicCityDao citydao = (DicCityDao) DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");

	public DataSet execute() {
		DataSet ds = new DataSet();
		ParameterSet pset = getParameterSet();
		ds = dao.query(pset);
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
}