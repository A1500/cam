package com.inspur.cams.sorg.check.somcheckauditopinion.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somcheckauditopinion.dao.SomCheckAuditOpinion;

/**
 * @title:SomCheckAuditOpinionQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckAuditOpinionQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckAuditOpinion> dao = (EntityDao<SomCheckAuditOpinion>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckauditopinion.dao.SomCheckAuditOpinionDao");
		return dao.query(pset);
	}
}
