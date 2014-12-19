package com.inspur.cams.marry.query.marry.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.marry.dao.NewMarryAvgAgeQueryDao;
/**
 * 初婚平均年龄查询统计
 * @author Ning
 *
 */
public class NewMarryAvgAgeQueryCmd extends BaseQueryCommand {
    
    private NewMarryAvgAgeQueryDao dao = (NewMarryAvgAgeQueryDao)DaoFactory.getDao(NewMarryAvgAgeQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
