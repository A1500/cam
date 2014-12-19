package com.inspur.cams.sorg.check.somchecklargedonation.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somchecklargedonation.dao.SomCheckLargeDonation;

/**
 * @title:SomCheckLargeDonationQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckLargeDonationQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckLargeDonation> dao = (EntityDao<SomCheckLargeDonation>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somchecklargedonation.dao.SomCheckLargeDonationDao");
		return dao.query(pset);
	}
}
