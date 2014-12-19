package com.inspur.cams.sorg.check.checkpublicbenefit.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkpublicbenefit.data.SomCheckPublicBenefit;

/**
 * @title:SomCheckPublicBenefitQueryCommand
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
public class SomCheckPublicBenefitQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckPublicBenefit> dao = (EntityDao<SomCheckPublicBenefit>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkpublicbenefit.dao.SomCheckPublicBenefitDao");
		return dao.query(pset);
	}
}
