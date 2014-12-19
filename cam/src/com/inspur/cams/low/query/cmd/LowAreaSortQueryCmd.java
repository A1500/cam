package com.inspur.cams.low.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.low.query.dao.LowAreaSortQueryDao;

public class LowAreaSortQueryCmd extends BaseQueryCommand {
    
    private LowAreaSortQueryDao dao = (LowAreaSortQueryDao)DaoFactory.getDao(LowAreaSortQueryDao.class);
    /*
     * 最低生活保障业务：按不同属地分类(央属、省属、市属、县属)
     */
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    /*
     * 最低生活保障业务：查看户数明细
     */
    public DataSet queryFamily(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getFamilyDataSet(pset);
    	return ds;
    }
    /*
     * 最低生活保障业务：查看人数明细
     */
    public DataSet queryPeople(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getPeopleDataSet(pset);
    	return ds;
    }
}
