package com.inspur.cams.comm.informUtil;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

/**
 * @title:PubOrganQueryCommand
 * @description:
 * @author:
 * @since:2010-12-04
 * @version:1.0
*/
public class InformPubOrganQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<InformPubOrgan> dao = (EntityDao<InformPubOrgan>) DaoFactory
				.getDao("com.inspur.cams.comm.informUtil.InformPubOrganDao");
		DataSet ds = dao.query(pset);
		ds.getMetaData().setIdProperty("organCode");
		return ds;
	}
	
	public DataSet queryNameByOrganType() {
		ParameterSet pset = getParameterSet();
		EntityDao<InformPubOrgan> dao = (EntityDao<InformPubOrgan>) DaoFactory
				.getDao("com.inspur.cams.comm.informUtil.InformPubOrganDao");
		pset.setParameter("ORGAN_TYPE@in", "11,12,13");
		DataSet ds = dao.query(pset);
		return ds;
	}
}
