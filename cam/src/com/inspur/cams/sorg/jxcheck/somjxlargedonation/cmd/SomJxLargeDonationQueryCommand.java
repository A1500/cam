package com.inspur.cams.sorg.jxcheck.somjxlargedonation.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonation;

/**
 * @title:SomJxLargeDonationQueryCommand
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
public class SomJxLargeDonationQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxLargeDonation> dao = (EntityDao<SomJxLargeDonation>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonationDao");
		return dao.query(pset);
	}
}
