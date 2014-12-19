package com.inspur.cams.marry.query.papers.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.papers.dao.ReplacementRevokedQueryDao;

/**
 * 补领、撤销统计
 * @author Ning
 *
 */
public class ReplacementRevokedQueryCmd extends BaseQueryCommand {
    
    private ReplacementRevokedQueryDao dao = (ReplacementRevokedQueryDao)DaoFactory.getDao(ReplacementRevokedQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
