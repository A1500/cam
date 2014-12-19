package com.inspur.cams.marry.query.marry.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.marry.dao.ReMarryAvgAgeQueryDao;
/**
 * 再婚平均年龄查询统计
 * @author Ning
 *
 */
public class ReMarryAvgAgeQueryCmd extends BaseQueryCommand {
    
    private ReMarryAvgAgeQueryDao dao = (ReMarryAvgAgeQueryDao)DaoFactory.getDao(ReMarryAvgAgeQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
