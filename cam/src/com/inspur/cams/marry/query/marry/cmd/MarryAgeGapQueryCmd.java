package com.inspur.cams.marry.query.marry.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.marry.dao.MarryAgeGapQueryDao;
/**
 * 结婚登记男女年龄差统计
 * @author Ning
 *
 */
public class MarryAgeGapQueryCmd extends BaseQueryCommand {
    
    private MarryAgeGapQueryDao dao = (MarryAgeGapQueryDao)DaoFactory.getDao(MarryAgeGapQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
