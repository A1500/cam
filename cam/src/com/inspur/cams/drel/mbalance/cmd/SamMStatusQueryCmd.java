package com.inspur.cams.drel.mbalance.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.drel.mbalance.data.SamMStatus;

/**
 * @title:SamMedicalStatusQueryCommand
 * @description:救助状态查询Command
 * @author:luguosui
 * @since:2011-06-01
 * @version:1.0
*/
public class SamMStatusQueryCmd extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SamMStatus> dao = (EntityDao<SamMStatus>) DaoFactory
				.getDao("com.inspur.cams.drel.mbalance.dao.jdbc.SamMStatusDao");
		return dao.query(pset);
	}
}
