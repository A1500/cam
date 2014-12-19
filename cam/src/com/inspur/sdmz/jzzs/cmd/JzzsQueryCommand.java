package com.inspur.sdmz.jzzs.cmd;





import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.sdmz.jzzs.dao.JzzsQueryDao;
/**
 * 
 * @author licunbing
 *
 */
public class JzzsQueryCommand extends BaseQueryCommand {
	public DataSet execute() {
		JzzsQueryDao dao = (JzzsQueryDao) DaoFactory.getDao(JzzsQueryDao.class);
		return dao.query(getParameterSet());
	}
}
