package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.sam.dao.jdbc.SamFamilySupportDao;
/**
 * 赡扶抚养人查询Cmd
 * @author yanliangliang
 *2012年5月2日9:45:43
 */
public class SamFamilySupportQueryCmd extends BaseQueryCommand{
	public DataSet execute() {
		SamFamilySupportDao dao = (SamFamilySupportDao) DaoFactory.getDao(SamFamilySupportDao.class);
		return dao.query(getParameterSet());
	}
}
