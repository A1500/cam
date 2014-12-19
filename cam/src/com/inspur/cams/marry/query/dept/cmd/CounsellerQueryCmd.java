package com.inspur.cams.marry.query.dept.cmd;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.dept.dao.CounsellorDao;


public class CounsellerQueryCmd extends BaseQueryCommand {
    
    private CounsellorDao dao = (CounsellorDao)DaoFactory.getDao(CounsellorDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}