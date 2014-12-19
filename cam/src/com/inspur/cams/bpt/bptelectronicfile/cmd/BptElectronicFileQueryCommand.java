package com.inspur.cams.bpt.bptelectronicfile.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicFile;
/**
 * @title:BptElectronicFileQueryCommand
 * @description:
 * @author:
 * @since:2011-06-27
 * @version:1.0
*/
public class BptElectronicFileQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptElectronicFile> dao = (EntityDao<BptElectronicFile>) DaoFactory
				.getDao("org.bptelectronicfile.dao.BptElectronicFileDao");
		return dao.query(pset);
	}
}
