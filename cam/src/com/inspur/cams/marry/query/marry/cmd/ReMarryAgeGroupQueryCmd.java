package com.inspur.cams.marry.query.marry.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.marry.dao.ReMarryAgeGroupQueryDao;
/**
 * 再婚登记年龄段查询统计
 * @author Ning
 *
 */
public class ReMarryAgeGroupQueryCmd extends BaseQueryCommand {
    
    private ReMarryAgeGroupQueryDao dao = (ReMarryAgeGroupQueryDao)DaoFactory.getDao(ReMarryAgeGroupQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
