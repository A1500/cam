package com.inspur.cams.marry.query.papers.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.papers.dao.ReissueMarryQueryDao;

/**
 * 补领、撤销统计
 *
 */
public class ReissueMarryQueryCmd extends BaseQueryCommand {
    
    private ReissueMarryQueryDao dao = (ReissueMarryQueryDao)DaoFactory.getDao(ReissueMarryQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
