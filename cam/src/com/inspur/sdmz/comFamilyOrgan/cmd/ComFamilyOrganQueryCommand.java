package com.inspur.sdmz.comFamilyOrgan.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.sdmz.comFamilyOrgan.dao.*;

/**
 * @title:ComFamilyOrganQueryCommand
 * @description:
 * @author:
 * @since:2011-09-17
 * @version:1.0
*/
public class ComFamilyOrganQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<ComFamilyOrgan> dao = (EntityDao<ComFamilyOrgan>) DaoFactory
				.getDao("com.inspur.sdmz.comFamilyOrgan.dao.ComFamilyOrganDao");
		return dao.query(pset);
	}
}
