package com.inspur.cams.marry.query.dept.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.dept.dao.MemsRegistrarPartOneDao;

public class MemsRegistrarPartOneCmd extends BaseQueryCommand {
    
    private MemsRegistrarPartOneDao dao = (MemsRegistrarPartOneDao)DaoFactory.getDao(MemsRegistrarPartOneDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
