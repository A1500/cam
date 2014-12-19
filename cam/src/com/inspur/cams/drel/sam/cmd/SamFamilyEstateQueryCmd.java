package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.sam.dao.jdbc.SamFamilyEstateDao;

/**
 * 家庭财产信息查询Cmd
 * @author yanliangliang
 *2012年5月2日9:45:43
 */
public class SamFamilyEstateQueryCmd extends BaseQueryCommand {
	@SuppressWarnings("unused")
	public DataSet execute() {
		SamFamilyEstateDao dao = (SamFamilyEstateDao) DaoFactory.getDao(SamFamilyEstateDao.class);
		return dao.query(getParameterSet());

	}
}
