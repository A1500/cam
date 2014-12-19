package com.inspur.cams.marry.query.marry.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.marry.dao.MarryStatusQueryDao;
/**
 * 婚姻状态查询统计
 * @author Ning
 *
 */
public class MarryStatusQueryCmd extends BaseQueryCommand {
    
    private MarryStatusQueryDao dao = (MarryStatusQueryDao)DaoFactory.getDao(MarryStatusQueryDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
