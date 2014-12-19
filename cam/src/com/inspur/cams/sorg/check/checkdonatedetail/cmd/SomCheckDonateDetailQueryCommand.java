package com.inspur.cams.sorg.check.checkdonatedetail.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkdonatedetail.data.SomCheckDonateDetail;


/**
 * @title:SomCheckDonateDetailQueryCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckDonateDetailQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckDonateDetail> dao = (EntityDao<SomCheckDonateDetail>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkdonatedetail.dao.SomCheckDonateDetailDao");
		return dao.query(pset);
	}
}
