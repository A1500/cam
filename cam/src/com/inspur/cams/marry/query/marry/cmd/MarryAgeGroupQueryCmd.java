package com.inspur.cams.marry.query.marry.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.marry.dao.MarryAgeGroupQueryDao;
/**
 * 结婚登记分年龄段查询统计
 * @author Ning
 *
 */
public class MarryAgeGroupQueryCmd extends BaseQueryCommand {
    
    private MarryAgeGroupQueryDao dao = (MarryAgeGroupQueryDao)DaoFactory.getDao(MarryAgeGroupQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
