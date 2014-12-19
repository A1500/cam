package com.inspur.cams.marry.query.papers.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.papers.dao.MarriageCertifierQueryDao;

/**
 * 婚姻登记员统计分析
 *
 */
public class MarriageCertifierQueryCmd extends BaseQueryCommand {
    
    private MarriageCertifierQueryDao dao = (MarriageCertifierQueryDao)DaoFactory.getDao(MarriageCertifierQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}