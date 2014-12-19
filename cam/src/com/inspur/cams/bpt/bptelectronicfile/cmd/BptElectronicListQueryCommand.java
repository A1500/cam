package com.inspur.cams.bpt.bptelectronicfile.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicList;

/**
 * @title:BptElectronicListQueryCommand
 * @description:
 * @author:
 * @since:2011-07-15
 * @version:1.0
*/
public class BptElectronicListQueryCommand extends BaseQueryCommand{

	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptElectronicList> dao = (EntityDao<BptElectronicList>) DaoFactory.getDao("com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicListDao");
		return dao.query(pset);
	}
}
