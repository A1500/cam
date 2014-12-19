package com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.dao.*;

/**
 * @title:SomJxCheckAuditOpinionQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckAuditOpinionQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckAuditOpinion> dao = (EntityDao<SomJxCheckAuditOpinion>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.dao.SomJxCheckAuditOpinionDao");
		return dao.query(pset);
	}
}
