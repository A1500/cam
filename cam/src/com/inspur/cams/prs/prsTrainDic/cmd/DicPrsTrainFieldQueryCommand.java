package com.inspur.cams.prs.prsTrainDic.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.prs.prsTrainDic.dao.DicPrsTrainFieldDao;

/**
 * @title:DicPrsTrainFieldQueryCommand
 * @description:
 * @author:
 * @since:2012-09-21
 * @version:1.0
*/
public class DicPrsTrainFieldQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DicPrsTrainFieldDao dao = (DicPrsTrainFieldDao) DaoFactory
		.getDao("com.inspur.cams.prs.prsTrainDic.dao.DicPrsTrainFieldDao");
		return dao.query(pset);
	}
}
