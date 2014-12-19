package com.inspur.cams.marry.query.divorce.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.divorce.dao.DivorceAvgAgeQueryDao;

public class DivorceAvgAgeQueryCmd extends BaseQueryCommand {
    
    private DivorceAvgAgeQueryDao dao = (DivorceAvgAgeQueryDao)DaoFactory.getDao(DivorceAvgAgeQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
