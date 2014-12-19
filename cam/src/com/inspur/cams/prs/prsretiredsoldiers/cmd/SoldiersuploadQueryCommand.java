package com.inspur.cams.prs.prsretiredsoldiers.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.prs.prsretiredsoldiers.dao.SoldiersUpload;

/**
 * @title:SoldiersuploadQueryCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class SoldiersuploadQueryCommand extends BaseQueryCommand{

	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SoldiersUpload> dao = (EntityDao<SoldiersUpload>) DaoFactory
				.getDao("com.inspur.cams.prs.prsretiredsoldiers.dao.SoldiersuploadDao");
		return dao.query(pset);
	}
}
