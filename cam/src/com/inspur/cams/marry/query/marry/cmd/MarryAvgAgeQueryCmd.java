package com.inspur.cams.marry.query.marry.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.marry.dao.MarryAvgAgeQueryDao;
/**
 * 结婚登记平均年龄统计
 * @author Ning
 *
 */
public class MarryAvgAgeQueryCmd extends BaseQueryCommand {
    
    private MarryAvgAgeQueryDao dao = (MarryAvgAgeQueryDao)DaoFactory.getDao(MarryAvgAgeQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
