package com.inspur.cams.drel.sam.cmd;

 
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.sam.dao.jdbc.FamilyQueryDao;

public class SamFamilyQueryCmd extends BaseQueryCommand {
	public DataSet execute() {
		FamilyQueryDao dao = (FamilyQueryDao) DaoFactory.getDao(FamilyQueryDao.class);
		return dao.query(getParameterSet());
	}
}
